(include "common.ss")
(include "math.ss")
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
;subst-f
(define seqS
 (lambda (new old l)
   (cons new l)))
(define subst-g 
(lambda (new old l)
    (((insert-g equal?)seqS)
    new old l)
))

(define seqrem
  (lambda (new old l) l))
;yyy-rember
(define yyy
   (lambda (a l)
      (((insert-g equal?)seqrem) #f a l)))

; atom-to-function
(define atom-to-function
 (lambda (atom)
   (cond
     ((eq? atom (quote +)) +)
     ((eq? atom (quote +)) ×)
     (else ^))))
(define value-a
 (lambda (nexp)
   (cond
     ((atom? nexp) nexp)
     (else
      ((atom-to-function (operator nexp))
       (value-a (1st-sub-exp nexp))
       (value-a (2nd-sub-exp nexp)))))))

(define 1st-sub-exp
 (lambda (aexp)
   (car (cdr aexp))))
(define 2nd-sub-exp
 (lambda (aexp)
   (car (cdr (cdr aexp)))))
(define operator
  (lambda (aexp)
    (car aexp)))

(define multirember-f
 (lambda (test?)
   (lambda (a lat)
     (cond
      ((null? lat) (quote ()))
      ((test? a (car lat))
       ((multirember-f test?) a (cdr lat)))
      (else
       (cons (car lat)
             ((multirember-f test?) a (cdr lat))))))))
(define multirember-eq?
 (multirember-f eq?))

(define eq?-tuna
  (eq?-c 'tuna))

(define multiremberT
 (lambda (test?)
   (lambda (lat)
     (cond
      ((null? lat) (quote ()))
      ((test? (car lat))
       ((multiremberT test?) (cdr lat)))
      (else
       (cons (car lat)
             ((multiremberT test?)(cdr lat))))))))

;col (list,list):bool
;multiremember&co (atom,list,(list,list):bool):bool
(define multiremember&co
  (lambda (a lat col)
    (cond
     ((null? lat)
      (col (quote ()) (quote ())))
     ((eq? (car lat) a)
      (multiremember&co a (cdr lat)
                      (lambda (newlat seen)
                        (col newlat
                             (cons (car lat) seen)))));和a相同则扔到seen中
     (else
      (multiremember&co a (cdr lat)
                      (lambda (newlat seen)
                        (col (cons (car lat) newlat) seen)))))));和a不同则扔到newlat中
(define a-friend
  (lambda (x y)
    (null? y)))
(define new-friend
  (lambda (newlat seen)
    (col newlat
      (cons (car lat) seen))))
(define old-friend
  (lambda (newlat seen)
    (col (cons (car lat) newlat) seen)))

;用来构造去除元素后剩余list的长途
(define last-friend
  (lambda (x y)
    (length x)))

(define multiinsertLR
 (lambda (new oldL oldR lat)
   (cond
    ((null? lat) (quote ()))
    ((eq? (car lat) oldL)
     (cons new
           (cons oldL
                 (multiinsertLR new oldL oldR
                                (cdr lat)))))
    ((eq? (car lat) oldR)
     (cons oldR
           (cons new
                 (multiinsertLR new oldL oldR
                                (cdr lat)))))
    (else
     (cons (car lat)
           (multiinsertLR new oldL oldR
                          (cdr lat)))))))

(define multiinsertLR&co
 (lambda (new oldL oldR lat col)
   (cond
    ((null? lat)
     (col (quote ()) 0 0))
    ((eq? (car lat) oldL)
     (multiinsertLR&co new oldL oldR
                       (cdr lat)
                       (lambda (newlat L R)
                         (col (cons new (cons (car lat) newlat)) (add1 L) R))))
    ((eq? (car lat) oldR)
     (multiinsertLR&co new oldL oldR
                       (cdr lat)
                       (lambda (newlat L R)
                         (col (cons (car lat) (cons new newlat)) L (add1 R)))))
    (else
     (multiinsertLR&co new oldL oldR
                       (cdr lat)
                       (lambda (newlat L R)
                         (col (cons (car lat) newlat) L R)))))))
(define colImp
 (lambda(lat L R)
    (display lat)
    (display L)(display " ")
    (display R)
    (newline)
))

;判断是否是偶数
(define even?
  (lambda (n)
    (= (x (/ n 2) 2) n)))
(define uneven?
  (lambda (n)
    (not (even? n))
    ))
(define evens-only*
 (lambda (test? lat)
    (cond
        ((null? lat) '())
        ((atom? (car lat)) 
            (cond
                ((test? (car lat)) (evens-only* test? (cdr lat)))
                (else (cons (car lat)(evens-only* test? (cdr lat))))))
        (else (cons (evens-only* test? (car lat))(evens-only* test? (cdr lat))))
)))
(define evens-only*&co
 (lambda (test? lat col)
  (cond
      ((null? lat) (col '() 1 0));0作为加的起始值,1作为乘的起始值
      ((atom? (car lat)) 
            (cond
                ((test? (car lat)) 
                 (evens-only*&co test? (cdr lat) 
                  (lambda (newlat yes no)
                   (col newlat(x yes (car lat)) no)
                  )))
                (else 
                 (evens-only*&co test? (cdr lat) 
                  (lambda(newlat yes no)
                   (col (cons (car lat) newlat) yes (+ (car lat) no))
                  )))))
      (else 
        (evens-only*&co test? (car lat) (lambda (al ap as)
            (evens-only*&co test? (cdr lat) 
             (lambda (dl dp ds)
              (col (cons al dl) (x ap dp)(+ as ds))
             ))
        )))
)))
(evens-only*&co 
  uneven?
  '((9 1 2 8) 3 10 ((9 9) 7 6) 2)
  colImp);((2 8) 10 (() 6) 2)15309 28
(evens-only*&co 
  even?
  '((9 1 2 8) 3 10 ((9 9) 7 6) 2)
  colImp);((9 1) 3 ((9 9) 7))1920 38