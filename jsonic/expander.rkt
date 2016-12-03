#lang br/quicklang
(require json)

(define-macro (js-module-begin PARSE-TREE)
  #'(#%module-begin
     (define result-string PARSE-TREE)
     (define validated-expr (string->jsexpr result-string))
     (display result-string)))
(provide (rename-out [js-module-begin #%module-begin]))

(define-macro (json-char CHAR-STR)
  #'CHAR-STR)
(provide json-char)

(define-macro (jsonic-program SEXP-OR-JSON-STR ...)
  #'(string-trim (string-append SEXP-OR-JSON-STR ...)))
(provide jsonic-program)

(define-macro (s-expr SEXP-STR)
  (with-pattern ([SEXP-DATUM (format-datum '~a #'SEXP-STR)])
    #'(jsexpr->string SEXP-DATUM)))
(provide s-expr)