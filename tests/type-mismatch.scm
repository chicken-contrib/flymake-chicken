(module test ()

(import scheme)

(call-with-output-file 123 (lambda (out) (display "foo")))
;; (call-with-output-file "123" (lambda (out) (display "foo")))

(string-append 456 "789")
;; (string-append "456" "789")

)

;; Warning: Invalid argument
;;   In file `-:5',
;;   At the toplevel,
;;   In procedure call:

;;     (scheme#call-with-output-file 123 (lambda (out) (scheme#display "foo")))

;;   Argument #1 to procedure `call-with-output-file' has an invalid type:

;;     fixnum

;;   The expected type is:

;;     string

;;   This is the expression:

;;     123

;;   Procedure `call-with-output-file' from module `scheme' has this type:

;;     (procedure (string (procedure (output-port) . *) #!rest *) . *)


;; Warning: Invalid argument
;;   In file `-:7',
;;   At the toplevel,
;;   In procedure call:

;;     (scheme#string-append 456 "789")

;;   Argument #1 to procedure `string-append' has an invalid type:

;;     fixnum

;;   The expected type is:

;;     string

;;   This is the expression:

;;     456

;;   Procedure `string-append' from module `scheme' has this type:

;;     (#!rest string -> string)
