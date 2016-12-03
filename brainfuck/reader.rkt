#lang br/quicklang
(require "parser.rkt")

; Reader
(define (read-syntax path port)
  (define parse-tree (parse path (tokenize port)))
  (define module-datum `(module bf-mod brainfuck/expander
                          ,parse-tree))
  (datum->syntax #f module-datum))
(provide read-syntax)

; Lexer
(require parser-tools/lex)
(define (tokenize port)
  (define (next-token)
    (define our-lexer
      (lexer
       [(eof) eof]
       [(char-set "><-.,+[]") lexeme]
       [any-char (next-token)]))
    (our-lexer port))
  next-token)