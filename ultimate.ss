(include "common.ss")
(define rember-f
(lambda (test? a lat) 
    (cond
        ((null? lat) '())
        ((test? a (car lat))(cdr lat))
        (else (cons (car lat)(rember-f test? a (cdr lat))))
)))
(define eq?-c
  (lambda (a)
    (lambda (x)
      (eq? a x))))

(define eq?-salad (eq?-c 'salad))

(define f-rember
 (lambda (test?)
   (lambda (a l)
     (cond
       ((null? l) (quote ()))
       ((test? (car l) a) (cdr l))
       (else (cons (car l) ((f-rember test?) a (cdr l))))
))))

(define insertL-f
(lambda (test?)
(lambda (new old lat)
    (cond
        ((null? lat) '())
        ((test? old (car lat)) (cons new (cons old (cdr lat))))        
        (else (cons (car lat) ((insertL-f test?)new old (cdr lat))))        
))))

(define insertR-f
 (lambda (test?)
   (lambda (new old l)
     (cond
      ((null? l) (quote ()))
      ((test? (car l) old)
       (cons old (cons new (cdr l))))
      (else
       (cons (car l)
             ((insertR-f test?) new old (cdr l)))))
)))

(define seqL
(lambda (new old lat) 
    (cons new (cons old lat))
))
(define seqR
(lambda (new old lat) 
    (cons old (cons new lat))
))
(define insert-g
(lambda (test?)
(lambda(seq)
(lambda (new old l)
     (cond
      ((null? l) (quote ()))
      ((test? (car l) old)
       (seq new old (cdr l)))
      (else
       (cons (car l)
             (((insert-g test?) seq) new old (cdr l)))))
))))
(define insert-g-l 
(lambda (new old l)
    (((insert-g equal?)seqL)new old l)
))
;直接使用匿名函数作为参数
(define insert-g-r 
(lambda (new old l)
    (((insert-g equal?)
        (lambda (new old lat) (cons old (cons new lat))))
    new old l)
))

