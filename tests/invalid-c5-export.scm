(module test
    (( :: lex:seq) bind)
  )

;; Syntax error (module): invalid export

;; 	(#:: lex:seq)
;; 	((#:: lex:seq) bind)

;; 	Expansion history:

;; 	<syntax>	  (##core#begin (module test ((#:: lex:seq) bind)))
;; 	<syntax>	  (module test ((#:: lex:seq) bind))	<--

;; Error: shell command terminated with non-zero exit status 17920: '/home/wasa/.chickens/5.3.0/bin/chicken' '-' -output-file 'a.c' -analyze-only -verbose
