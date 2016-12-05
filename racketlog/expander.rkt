#lang br/quicklang
(require racketlog)
(provide ; Transliteration
         racketlog-program clause query functor term
         ; Implementation
         <- ?
         ; Macro Setup
         (rename-out [racketlog-module-begin #%module-begin]))

(define-macro (racketlog-module-begin PARSE-TREE)
  #'(#%module-begin
     PARSE-TREE))

; Transliteration
(define-macro (racketlog-program CLAUSES ... QUERY)
  #'(begin
      CLAUSES ...
      QUERY
      ))

(define-macro-cases clause
  [(clause (predicate PRED) ".")
   #'(<- PRED)]
  [(clause (predicate HEAD) ":-" (predicate-list (predicate PRED) ...) ".")
   #'(<- HEAD PRED ...)])

(define-macro (query "?" (predicate-list (predicate PRED) ...) ".")
  #'(? PRED ...))

(define-macro (functor NAME "(" (term-list TERM-LIST ...) ")")
  (with-pattern ([S-NAME (format-datum '~a #'NAME)])
    #'(list 'S-NAME TERM-LIST ...)))

(define-macro (term TERM)
  #'TERM)


; Implementation
(define-macro (<- KB ...)
  #'(displayln (list "<-" KB ...)))

(define-macro (? S ...)
  #'(displayln (list "?" S ...)))