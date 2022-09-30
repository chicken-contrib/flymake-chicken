(module test
    (( :: lex:seq) bind)
  )

;; Syntax error (module): invalid export

;; 	(#:: lex:seq)
;; 	((#:: lex:seq) bind)

;; 	Expansion history:

;; 	<syntax>	  (##core#begin (module test ((#:: lex:seq) bind)))
;; 	<syntax>	  (module test ((#:: lex:seq) bind))	<--
