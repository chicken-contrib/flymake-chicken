(module test ()

(import scheme)

(display (format "foo~%"))

(chop '(1 2 3) 2)

)

;; Error: Module `test' has unresolved identifiers
;;   In file `-':

;;   Unknown identifier `format'
;;     On line 5
;;   Suggestion: try importing one of these modules:
;;     chicken.format
;;     srfi-28

;;   Unknown identifier `chop'
;;     On line 7
;;   Suggestion: try importing module `chicken.base'
