(include "common.ss")
;将()作为0,(())作为1,(()())作为2
;sero? 特殊版本的zero?
(define sero?
 (lambda (n)
   (null? n)))
;edd1 特殊版本的add1
(define edd1
(lambda(n)
  (cons '() n)
))
;zub1
(define zub1
 (lambda (n)
   (cdr n)))

(define adds
(lambda (n m)
    (cond
        ((sero? m) n)
        (else  (edd1(adds n (zub1 m)))))
))

; tat? just like lat? 判断list中是否都是原子
;
(define tat?
  (lambda (l)
    (cond
      ((null? l) #t)
      ((atom? (car l))
       (tat? (cdr l)))
      (else #f))))