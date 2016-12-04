#lang br/quicklang
(require racketlog)

(define-macro (racketlog-module-begin PARSE-TREE)
  #'(#%module-begin
     PARSE-TREE))
(provide (rename-out [racketlog-module-begin #%module-begin]))

(define-macro (racketlog-program RACKETLOG-PROGRAM)
  #'RACKETLOG-PROGRAM)
(provide racketlog-program)
