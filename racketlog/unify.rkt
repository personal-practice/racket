#lang racket
(provide unify)

; Constants - Variables
(define (variable? s)
  (and (string? s)
       (char-upper-case? (string-ref s 0))))
                   
(define (constant? s)
  (and (string? s)
       (char-lower-case? (string-ref s 0))))

; Occurs check
(define (occurs? variable pattern)
  (cond
    [(equal? variable pattern) #t]
    [(or (variable? pattern) (constant? pattern)) #f]
    [(or (occurs? variable (car pattern))
         (occurs? variable (cdr pattern)))]))

; Bindings
(define get-binding assoc)  

(define get-binding-value cdr)

(define (add-binding variable value bindings)
  (cons (cons variable value) bindings))

; Unification
(define (match-variable variable pattern bindings)
  (println (list variable " =?= " pattern))
  (cond
    [(equal? variable pattern)
     bindings]
    [#t
     (let ([binding (get-binding variable bindings)])
       (println (list "Binding: " binding))
       (cond
         [binding
          (unify (get-binding-value binding) pattern bindings)]
         [(occurs? variable pattern)
          (println "Occurs")
          'fail]
         [#t
          (println (list "++ " variable ": " pattern))
          (add-binding variable pattern bindings)]))]))

(define (unify pattern-1 pattern-2 bindings)
  (println (list pattern-1 " ?? " pattern-2))
  (cond
    [(equal? bindings 'fail) 'fail]
    [(variable? pattern-1)
     (match-variable pattern-1 pattern-2 bindings)]
    [(variable? pattern-2) 
     (match-variable pattern-2 pattern-1 bindings)]
    [(constant? pattern-1)
     (if (equal? pattern-1 pattern-2)
         bindings
         'fail)]
    [(constant? pattern-2)
     'fail]
    [(unify (cdr pattern-1)
            (cdr pattern-2)
            (unify (car pattern-1)
                   (car pattern-2)
                   bindings))]))


; TEST

;(unify '("p" "a") '("q" "b") '())
;(unify (cons "p" "X") (cons "p" "orestis") '())
(unify (cons "p" "X") (cons "p" "orestis") '())

