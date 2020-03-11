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
(println(intersect?
  '(stewed tomatoes and macaroni)
  '(macaroni and cheese)))
(println(intersect?
  '(a b c)
  '(d e f)))