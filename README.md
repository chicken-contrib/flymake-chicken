## About

Syntax checking support for [CHICKEN Scheme] in Emacs using Flymake.

## Requirements

Emacs 26.1 or later. For older versions, use [flymake-chicken.el] from
[the CHICKEN repository].

## Installation

Install the package manually for the time being.

## Usage

Add the following to your init file:

    (defun flymake-chicken-init ()
      (add-hook 'flymake-diagnostic-functions #'flymake-chicken-backend nil t))

    (add-hook 'scheme-mode-hook #'flymake-chicken-init)

## Customization

If `csc` cannot be found on `PATH`, consider customizing
`flymake-chicken-command`.

[CHICKEN Scheme]: https://call-cc.org
[flymake-chicken.el]: http://code.call-cc.org/cgi-bin/gitweb.cgi?p=chicken-core.git;a=blob_plain;f=misc/flymake-chicken.el;hb=HEAD
[the CHICKEN repository]: http://code.call-cc.org/cgi-bin/gitweb.cgi?p=chicken-core.git
