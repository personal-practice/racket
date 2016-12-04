#lang br
(require racketlog/parser
         racketlog/tokenizer
         brag/support)

;(parse (apply-tokenizer tokenize "//Silly example\n fact(1234).\n ?query(X)."))