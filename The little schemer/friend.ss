(include "common.ss")
;member? 改进版,使用equal?代替eq?
(define member?
(lambda (a lat)
(cond
    ((null? lat) #f)
    ((equal? a (car lat)) #t)
    (else (member? a (cdr lat))))))
;判断list是不是set
(define set?
(lambda (lat)
    (cond
        ((null? lat) #t)
        ((member? (car lat)(cdr lat)) #f)
        (else (set? (cdr lat)))
)))
;makeset 
(define makeset
(lambda (lat) 
    (cond
        ((null? lat) '())
        ((member? (car lat)(cdr lat)) (makeset (cdr lat)))
        (else (cons (car lat)(makeset(cdr lat))))
    )))

;multirember 改进版,使用equal?代替eq?
(define multirember
  (lambda (old lat)
    (cond
      ((null? lat)  `())
      ((equal? old (car lat))(multirember old (cdr lat)))
      (else (cons (car lat)(multirember old (cdr lat))))
      )))
;makeset-multirember  
(define makeset-multirember
(lambda (lat)
    (cond
        ((null? lat) '())
        (else (cons (car lat)(makeset-multirember(multirember (car lat)(cdr lat)))))
        )))
;subset? 是否是子集
(define subset?
(lambda (set1 set2) 
    (cond
        ((null? set1) #t)
        ((member? (car set1) set2) (subset? (cdr set1) set2))
        (else #f) 
)))
;eqset? set元素是否相同
(define eqset?
(lambda (set1 set2)
(and (subset? set1 set2)(subset? set2 set1))
))
;intersect? set1 set2中是否有相同元素
(define intersect?
(lambda (set1 set2)
    (cond
        ((null? set1) #f)
        ((member? (car set1) set2) #t)
        (else (intersect? (cdr set1) set2))
        )))
;intersect 取交集
(define intersect
(lambda (set1 set2)
    (cond
        ((null? set1) '())
        ((member? (car set1) set2) (cons (car set1) (intersect (cdr set1) set2)))
        (else (intersect (cdr set1) set2))
        )))
;union 取并集  
(define union
(lambda (set1 set2)
    (cond
        ((null? set1) set2)
        ((member? (car set1) set2) (union (cdr set1) set2))
        (else (cons (car set1)(union (cdr set1) set2))))
))
;xxx 属于set1不属于set2的元素
(define xxx
  (lambda (set1 set2)
    (cond
     ((null? set1) '())
     ((member? (car set1) set2)
      (xxx (cdr set1) set2))
     (else
      (cons (car set1)
            (xxx (cdr set1) set2))))))

;intersectall 
(define intersectall 
(lambda (lat)
    (cond
        ((null? (cdr lat))(car lat))
        (else (intersect (car lat)(intersectall (cdr lat)))))
))

;a-pair
(define a-pair?
 (lambda (x)
   (cond
     ((atom? x) #f)
     ((null? x) #f)
     ((null? (cdr x)) #f)
     ((null? (cdr (cdr x))) #t)
     (else #f))))

(define first
  (lambda (p)
    (car p)))

(define second
  (lambda (p)
    (car (cdr p))))

(define third
 (lambda (p)
   (car (cdr (cdr p)))))

(define build
  (lambda (s1 s2)
    (cons s1 (cons s2 (quote ())))))  

; Example of a not-relations
;
'(apples peaches pumpkins pie);不是pair组成的数组
'((apples peaches) (pumpkin pie) (apples peaches));有重复的pair

; Examples of relations
;
'((apples peaches) (pumpkin pie))
'((4 3) (4 2) (7 6) (6 2) (3 4))

;fun? 判断一个relations是不是function(有限函数是pair对组成的list表，其中每个pair的第一个元素没有相同的) 
(define fun?
 (lambda (rel)
   (set? (firsts rel))))
;revpair
(define revpair
  (lambda (pair)
    (build (second pair) (first pair))))
;revrel
(define revrel
(lambda (rel)
    (cond
        ((null? rel) '())
        (else (cons (revpair (car rel))(revrel (cdr rel))))
    )))
;fullfun? 每个pair的第二个元素没有相同的 one-to-one一对一
(define fullfun?
 (lambda (fun)
   (set? (seconds fun))))
;seconds
(define seconds
  (lambda (l)
    (cond
      ((null? l) '())
      (else
        (cons (second (car l)) (seconds (cdr l)))))))
;one-to-one?
(define one-to-one?
 (lambda (fun)
   (fun? (revrel fun))))
