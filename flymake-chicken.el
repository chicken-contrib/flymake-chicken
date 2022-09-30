;;; flymake-chicken.el --- Flymake support for CHICKEN  -*- lexical-binding: t; -*-

;; Copyright (C) 2022 Vasilij Schneidermann <mail@vasilij.de>

;; Author: Vasilij Schneidermann <mail@vasilij.de>
;; URL: https://depp.brause.cc/flymake-chicken
;; Version: 0.0.1
;; Package-Requires: ((emacs "26.1"))
;; Keywords: languages

;; This file is NOT part of GNU Emacs.

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING. If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; Provides flymake support to perform on-the-fly syntax checks for
;; CHICKEN Scheme programs. The following customization is required:

;; (defun flymake-chicken-init ()
;;   (add-hook 'flymake-diagnostic-functions #'flymake-chicken-backend nil t))

;; (add-hook 'scheme-mode-hook #'flymake-chicken-init)

;;; Code:

(require 'rx)
;; Yes, that's how their documentation tells you to use it
(eval-when-compile (require 'subr-x))

(defgroup flymake-chicken nil
  "CHICKEN Scheme doc commands"
  :group 'languages
  :link '(custom-group-link :tag "Flymake" flymake)
  :prefix "flymake-chicken-")

(defcustom flymake-chicken-command (list (executable-find "csc") "-Av" "-")
  "Command executed to perform the syntax check."
  :group 'flymake-chicken
  :type '(repeat string))
(put 'flymake-chicken-command 'risky-local-variable t)

(defvar flymake-chicken-warning-rx
  (rx bol "Warning: "))

(defvar flymake-chicken-warning-or-error-rx
  (rx bol (or "Warning" "Error" "Syntax error"
              (: "Syntax error (" (+ (not (any ")")))")"))
      ": "))

(defvar flymake-chicken-csc-error-rx
  (rx "Error: shell command terminated with non-zero exit status"
      (+ (not (any ":")))
      ":" (+ any)
      "-verbose"))

(defun flymake-chicken--parse-buffer ()
  (let (warnings)
    (goto-char (point-min))
    (while (re-search-forward flymake-chicken-warning-or-error-rx nil t)
      (let ((beg (match-beginning 0)))
        (forward-line 1)
        (if (looking-at-p flymake-chicken-warning-rx)
            ;; consecutive warning lines paragraph
            (let ((end (or (search-forward "\n\n") (point-max))))
              (push (string-trim-right (buffer-substring beg end)) warnings))
          ;; whitespace-preceded lines terminated by next warning/error
          (let ((end (if (save-excursion
                           (re-search-forward flymake-chicken-warning-or-error-rx nil t))
                         (match-beginning 0)
                       (point-max))))
            (let ((warning (buffer-substring beg end)))
              ;; avoid false positive from terminating csc error
              (when (not (string-match-p flymake-chicken-csc-error-rx warning))
                (push (string-trim-right warning) warnings)))))))
    (nreverse warnings)))

(defvar flymake-chicken-warning-line-rx
  (rx (or (: bol (or "Warning" "Syntax error")
             ": (-:" (group-n 1 (+ (any "0-9"))) ")")
          (: "In file `-:" (group-n 1 (+ (any "0-9"))) "',"))))

(defun flymake-chicken--parse-output (source proc report-fn)
  (let (diags)
    (with-current-buffer (process-buffer proc)
      (dolist (warning (flymake-chicken--parse-buffer))
        (let* ((line (if (string-match flymake-chicken-warning-line-rx warning)
                         (string-to-number (match-string 1 warning))
                       0))
               (source-region (flymake-diag-region source line))
               (beg (car source-region))
               (end (cdr source-region))
               (type :warning))
          (push (flymake-make-diagnostic source beg end type warning) diags))))
    (funcall report-fn (nreverse diags))))

(defvar-local flymake-chicken--process nil)

;;;###autoload
(defun flymake-chicken-backend (report-fn &rest _args)
  "Flymake backend for CHICKEN Scheme.
This backend uses `flymake-chicken-command' to launch a process
that is passed the current buffer's content via stdin. REPORT-FN
is flymake's callback function."
  (when (not (executable-find (car flymake-chicken-command)))
    (error "`csc` executable not found. Customize `flymake-chicken-command'"))
  (when (process-live-p flymake-chicken--process)
    (kill-process flymake-chicken--process))

  (let ((source (current-buffer)))
    (save-restriction
      (widen)
      (setq flymake-chicken--process
            (make-process
             :name "flymake-chicken"
             :noquery t
             :connection-type 'pipe
             :buffer (generate-new-buffer " *flymake-chicken*")
             :command flymake-chicken-command
             :sentinel
             (lambda (proc _event)
               (when (eq 'exit (process-status proc))
                 (unwind-protect
                     (when (with-current-buffer source
                             (eq proc flymake-chicken--process))
                       (flymake-chicken--parse-output source proc report-fn))
                   (kill-buffer (process-buffer proc)))))))
      (process-send-region flymake-chicken--process (point-min) (point-max))
      (process-send-eof flymake-chicken--process))))

(provide 'flymake-chicken)
;;; flymake-chicken.el ends here
