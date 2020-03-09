;list lat的自然递归是 xxx(cdr lat)
;数 m的自然递归是 xxx(sub1 m)

;+
;1+(n+(m-1)) 
;1+(1+(n+(m-1-1))) 
;1+(1+(1+(n+(m-1-1-1))))
;1+(1+...(n+(m-....1-1))) m减到0
(define +
 (lambda (n m)
   (cond
     ((zero? m) n)
     (else (add1 (+ n (sub1 m)))))));

;-
;(n+(m-1))-1 
;(n+(m-1-1))-1-1
;(n+(m-1-1-1))-1-1
;(n+(m-....1-1)))...-1-1-1 m减到0
(define -
 (lambda (n m)
   (cond
     ((zero? m) n)
     (else (sub1 (- n (sub1 m)))))));sub1(sub1(sub1(n))) 减m次

;x
;n+(n*(m-1))
;n+(n+(n*(m-1-1)))
;n+(n+(n+(n*(m-1-1-1))))
;n+(n+(n+...(n*(m...-1-1-1))))m减到0
;这里使用的是+来构建数,使用0作为终止值
;如果使用*来构建数，则应该使用1作为终止值
;使用cons来构建数组使用()作为终止值
(define x
(lambda (n m)
(cond
    ((zero? m) 0)
    (else (+ n (x n(sub1 m)))))))

;addtup 计算tup中所有数的总和
(define addtup    
(lambda (tup) 
(cond
    ((null? tup) 0)
    (else (+ (car tup) (addtup (cdr tup)))))))

;tup+ 
; (define tup+
; (lambda (tup1 tup2)
; (cond
;     ((and (null? tup1)(null? tup2)) '())
;     (else (cons (+(car tup1)(car tup2))(tup+ (cdr tup1)(cdr tup2)))))))
;两个tup长度可以不同
(define tup+
  (lambda (tup1 tup2)
    (cond
     ((null? tup1) tup2);一个tup为空则后续不用计算取另一个tup的剩余元素
     ((null? tup2) tup1)
     (else
      (cons (+ (car tup1) (car tup2))
            (tup+
             (cdr tup1) (cdr tup2)))))))

;>
(define >
(lambda (n m)
(cond
    ((zero? n) #f)
    ((zero? m) #t)
    (else (>(sub1 n)(sub1 m))))))
;<
(define <
(lambda (n m)
   (cond
     ((zero? m) #f)
     ((zero? n) #t)
     (else (< (sub1 n) (sub1 m))))))
;=
; (define =
;   (lambda (n m)
;     (cond
;       ((zero? m) (zero? n))
;       ((zero? n) #f)
;       (else (= (sub1 n) (sub1) m)))))
;使用< >函数实现=
(define =
(lambda(n m)
(cond
    ((or(> n m)(< n m)) #f)
    (else #t))))

(define <=
(lambda(n m)
(cond
    ((or(< n m)(= n m)) #t)
    (else #f))))

(define >=
(lambda(n m)
(cond
    ((or(> n m)(= n m)) #t)
    (else #f))))

;^乘方  
(define ^
(lambda (n m)
(cond
    ((zero? m) 1)
    (else (x n (^ n (sub1 m)))))))
;/除法
(define /
  (lambda (n m)
    (cond
      ((< n m) 0)
        (else (add1 (/ (- n m) m))))))

;length 计算list长度
(define length
(lambda (lat)
(cond
    ((null? lat) 0)
    (else (add1 (length(cdr lat)))))))

;pick  
(define pick
(lambda (i lat)
(cond
    ((eq? i 1) (car lat))
    (else (pick (sub1 i) (cdr lat))))))

;rempick
(define rempick
(lambda (i lat)
(cond
    ((eq? i 1) (cdr lat))
    (else (cons (car lat)(rempick (sub1 i)(cdr lat)))))))

;no-nums
(define no-nums
(lambda (lat)
(cond
    ((null? lat) '())
    ((number? (car lat)) (no-nums (cdr lat)))
    (else (cons (car lat)(no-nums (cdr lat))))
    )))

;all-numbs
(define all-numbs
(lambda (lat)
(cond
    ((null? lat) '())
    ((number? (car lat))(cons (car lat)(all-numbs (cdr lat))))
    (else (all-numbs (cdr lat)))
)))

;occur
(define occur
(lambda (a lat)
(cond
    ((null? lat) 0)
    ((eq? a (car lat))(add1(occur a (cdr lat))))
    (else (occur a (cdr lat)))
)))

;one?
(define one?
(lambda (a)
(cond
    ((and (number? a)(zero? (sub1 a))) #t)
    (else #f))))

