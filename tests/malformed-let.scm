(module test ()

(import scheme)

(let ((foo 1)))

)

;; Syntax error: (-:5) in `let' - not enough arguments

;;         (let ((foo 1)))

;;         Expansion history:

;;         <syntax>          (##core#begin (module test () (import scheme) (let ((foo 1)))))
;;         <syntax>          (module test () (import scheme) (let ((foo 1))))
;;         <syntax>          (##core#module test () (import scheme) (let ((foo 1))))
;;         <syntax>          (import scheme)
;;         <syntax>          (##core#begin (##core#require library scheme))
;;         <syntax>          (##core#require library scheme)
;;         <syntax>          (##core#callunit library)
;;         <syntax>          (let ((foo 1)))       <--

;; Error: shell command terminated with non-zero exit status 17920: '/home/wasa/.chickens/5.3.0/bin/chicken' '-' -output-file 'a.c' -analyze-only -verbose
