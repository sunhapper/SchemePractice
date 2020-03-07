;+
(define +
 (lambda (n m)
   (cond
     ((zero? m) n)
     (else (add1 (+ n (sub1 m)))))));add1(add1(add1(n))) 加m次

;-
(define -
 (lambda (n m)
   (cond
     ((zero? m) n)
     (else (sub1 (- n (sub1 m)))))));sub1(sub1(sub1(n))) 减m次
