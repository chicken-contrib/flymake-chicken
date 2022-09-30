(module test ()

(import scheme)
;; (import (except scheme log))

(define (log . args)
  (for-each display args)
  (newline))

)

;; Warning: redefinition of imported value binding: log

;; Warning: (-:6) - assignment to imported value binding `log'

;; Warning: Invalid assignment
;;   At the toplevel,
;;   In assignment:

;;     (set! scheme#log (lambda args (let (...) (scheme#newline))))

;;   Variable `log' is assigned invalid value.

;;   The assigned value has this type:

;;     (#!rest -> undefined)

;;   The declared type of `log' from module `scheme' is:

;;     (number -> (or float cplxnum))

;; Warning: redefinition of standard binding: scheme#log
