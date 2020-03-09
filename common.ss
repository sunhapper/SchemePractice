;add1, sub1, zero?, car, cdr, cons, null?, eq?, atom?, number?都是元函数
;println 结尾换行的display
(define println
(lambda (a)
(display a)(newline)
)
)
;atom？ 参数是一个S表达式，判断是不是原子
(define atom?
(lambda (s)
(and (not(pair? s))(not (null? s)))))

;lat? 参数是一个list，判断所有元素是不是都是原子
(define lat?
(lambda (lat)
(cond
    ((null? lat) #t)
    ((atom? (car lat)) (lat? (cdr lat)))
    (else #f))))

;member? 参数是一个s表达式和一个list,判断s表达式是不是list的元素  
(define member?
(lambda (a lat)
(cond
    ((null? lat) #f)
    ((eq? a (car lat)) #t)
    (else (member? a (cdr lat))))))

;rember 接收两个参数，一个原子和一个列表，删除列表中的原子
(define rember
(lambda (a lat)
(cond
    ((null? lat) '())
    ((eq? a (car lat)) (cdr lat))
    (else (cons (car lat)(rember a (cdr lat)))))))


;firsts 取非空列表组成的列表的第一个元素组成新的列表  
(define firsts
(lambda (lat) 
(cond
    ((null? lat) '())
    (else 
        (cons (car(car lat))(firsts (cdr lat)))))))

;insertR 
(define insertR
  (lambda (new old lat)
    (cond
      ((null? lat)  `())
      ((eq?(car lat) old) (cons old (cons new (cdr lat))))
      (else (cons (car lat) (insertR new old (cdr lat))))
      )))
;insertL
(define insertL
  (lambda (new old lat)
    (cond
      ((null? lat)  `())
      ((eq?(car lat) old) (cons new lat))
      (else (cons (car lat) (insertL new old (cdr lat))))
      )))
;subst 替换第一个相同元素
(define subst
  (lambda (new old lat)
    (cond
      ((null? lat)  `())
      ((eq?(car lat) old) (cons new (cdr lat)))
      (else (cons (car lat) (subst new old (cdr lat))))
      )))
;subst2 
(define subst2
  (lambda (new o1 o2 lat)
    (cond
      ((null? lat)  `())
      ((or (eq?(car lat) o1)(eq?(car lat) o2)) (cons new (cdr lat)))
      (else (cons (car lat) (subst2 new o1 o2 (cdr lat))))
      )))
;multirember 删除全部匹配元素
(define multirember
  (lambda (old lat)
    (cond
      ((null? lat)  `())
      ((eq? old (car lat))(multirember old (cdr lat)))
      (else (cons (car lat)(multirember old (cdr lat))))
      )))
;multiinsertL
(define multiinsertL
  (lambda(new old lat)
    (cond
      ((null? lat) '())
      ((eq? old (car lat))
       (cons new (cons old (multiinsertL new old (cdr lat)))))
      (else
       (cons (car lat) (multiinsertL new old (cdr lat))))
      )
    )
  )
;multiinsertR
(define multiinsertR
(lambda (new old lat)
(cond
    ((null? lat) '())
    ((eq? (car lat) old) (cons old (cons new (multiinsertR new old (cdr lat)))))
    (else (cons (car lat)(multiinsertR new old (cdr lat)))))))
;multisubst
(define multisubst
(lambda (new old lat) 
(cond
    ((null? lat) '())
    ((eq?(car lat) old) (cons new (multisubst new old(cdr lat))))
    (else (cons (car lat)(multisubst new old(cdr lat))))
    )))