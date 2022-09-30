(module test ()

(import scheme)
(import (chicken base))

(condition-case
 (/ 1 0)
 (exn () (print "Boom!")))

)

;; Syntax error: illegal atomic form: ()

;;   Perhaps you intended to use the syntax `(condition-case ...)' without importing it first.
;;   Suggesting: `(import chicken.condition)'


;;         Expansion history:

;;         <syntax>          (##core#begin (module test () (import scheme) (import (chicken base)) (condition-case (/ 1 0) (exn (...
;;         <syntax>          (module test () (import scheme) (import (chicken base)) (condition-case (/ 1 0) (exn () (print "Boom...
;;         <syntax>          (##core#module test () (import scheme) (import (chicken base)) (condition-case (/ 1 0) (exn () (prin...
;;         <syntax>          (import scheme)
;;         <syntax>          (##core#begin (##core#require library scheme#))
;;         <syntax>          (##core#require library scheme#)
;;         <syntax>          (##core#undefined)
;;         <syntax>          (import (chicken base))
;;         <syntax>          (##core#begin (##core#require library chicken.base#))
;;         <syntax>          (##core#require library chicken.base#)
;;         <syntax>          (##core#undefined)
;;         <syntax>          (condition-case (/ 1 0) (exn () (print "Boom!")))
;;         <syntax>          (/ 1 0)
;;         <syntax>          (exn () (print "Boom!"))      <--
