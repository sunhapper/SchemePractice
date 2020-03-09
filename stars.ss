(include "common.ss")
;rember*
(define rember*
  (lambda (a lat)
    (cond
      ((null? lat) '())
      ((atom? (car lat)) 
        (cond
            ((eq? a (car lat)) (rember* a (cdr lat)))
            (else (cons (car lat)(rember* a (cdr lat))))
            ))
      (else (cons(rember* a (car lat))(rember* a (cdr lat))))
      )))

;insertR*
(define insertR*
  (lambda (new old lat)
    (cond
      ((null? lat) '())
      ((atom? (car lat)) 
        (cond
          ((eq? old (car lat)) 
            (cons old (cons new (insertR* new old (cdr lat)))))
          (else (cons (car lat) (insertR* new old (cdr lat))))))
      (else (cons (insertR* new old (car lat))(insertR* new old (cdr lat)))))))

;occur*
(define occur*
  (lambda (a lat)
    (cond
        ((null? lat) 0)
        ((atom? (car lat)) 
            (cond
                ((eq? a (car lat)) (add1(occur* a (cdr lat))))
                (else (occur* a (cdr lat)))))
        (else (+ (occur* a (car lat))(occur* a (cdr lat)))))))

;subst*
(define subst*
  (lambda (new old lat)
    (cond
        ((null? lat) '())
        ((atom? (car lat)) 
            (cond
                ((eq? old (car lat)) (cons new (subst* new old (cdr lat))))
                (else (cons (car lat) (subst* new old (cdr lat))))
                ))
        (else (cons (subst* new old (car lat))(subst* new old (cdr lat)))))))

;insertL*
(define insertL*
  (lambda (new old lat)
    (cond
      ((null? lat) '())
      ((atom? (car lat)) 
        (cond
          ((eq? old (car lat)) 
            (cons new (cons old (insertL* new old (cdr lat)))))
          (else (cons (car lat) (insertL* new old (cdr lat))))))
      (else (cons (insertL* new old (car lat))(insertL* new old (cdr lat)))))))
;member  
(define member*
 (lambda (a l)
   (cond
    ((null? l) #f)
    ((atom? (car l))
     (or (eq? (car l) a)
         (member* a (cdr l))))
    (else (or (member* a (car l))
              (member* a (cdr l)))))))

;leftmost
(define leftmost
  (lambda (lat)
    (cond
      ((atom? (car lat)) (car lat))
      (else (leftmost (car lat))
      ))))
;eqlist?
(define eqlist?
(lambda (l1 l2) 
    (cond
        ((and (null? l1) (null? l2)) #t);都是空list
        ((or (null? l1)(null? l2)) #f);有一个不是空list
        ((and (atom? (car l1))(atom? (car l2))) ;car 都是原子
            (and (eq? l1 l2)(eqlist? (cdr l1)(cdr l2))))
        ((or (atom? (car l1))(atom? (car l2))) #f);一个car不是原子
        (else (and 
                ((eqlist?(car l1)(car l2)))
                ((eqlist?(cdr l1)(cdr l2)))))
)))
(println(eqlist?
  '(strawberry ice cream)
  '(strawberry ice cream)) )                 ; #t

; (eqlist?
;   '(strawberry ice cream)
;   '(strawberry cream ice))                  ; #f

; (eqlist?
;   '(banan ((split)))
;   '((banana) split))                        ; #f

; (eqlist?
;   '(beef ((sausage)) (and (soda)))
;   '(beef ((salami)) (and (soda))))          ; #f

; (eqlist?
;   '(beef ((sausage)) (and (soda)))
;   '(beef ((sausage)) (and (soda))))         ; #t


