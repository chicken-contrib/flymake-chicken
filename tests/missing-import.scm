(module test ()

(import scheme)

(display (format "foo~%"))

(chop '(1 2 3) 2)

)

;; Warning: reference to possibly unbound identifier `format'
;; Warning:    suggesting one of:
;; Warning:    (import chicken.format)
;; Warning:    (import srfi-28)

;; Warning: reference to possibly unbound identifier `chop'
;; Warning:    suggesting: `(import chicken.base)'

;; Error: module unresolved: test
