(include "math.ss")
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


;========= for 06-shadows.ss======= 
;numbered? 判断一个s表达式是否是算数表达式的表示法
(define numbered?
  (lambda (aexp)
    (cond
      ((atom? aexp) (number? aexp))
      ((eq? (car (cdr aexp)) '+)
       (and (numbered? (car aexp))
            (numbered? (car (cdr (cdr aexp))))))
      ((eq? (car (cdr aexp)) 'x)
       (and (numbered? (car aexp))
            (numbered? (car (cdr (cdr aexp))))))
      ((eq? (car (cdr aexp)) '^)
       (and (numbered? (car aexp))
            (numbered? (car (cdr (cdr aexp))))))
      (else #f))))
;numbered? 判断是不是中缀算数表达式
(define numbered?
 (lambda (aexp)
   (cond
     ((atom? aexp) (number? aexp))
     (else (and (numbered? (car aexp)) 
                (numbered? (car (cdr (cdr aexp)))))))))
;value 计算中缀算数表达式的值
(define value
 (lambda (nexp)
   (cond
     ((atom? nexp) nexp)
     ((eq? (car (cdr nexp)) '+) (+ (value(car nexp))(value (car(cdr(cdr nexp))))))
     ((eq? (car (cdr nexp)) 'x) (x (value(car nexp))(value (car(cdr(cdr nexp))))))
     (else (^ (value(car nexp))(value (car(cdr(cdr nexp))))))
)))
;value-prefix 计算前缀算数表达式的值
(define value-prefix
(lambda(nexp)
    (cond
        ((atom? nexp) nexp)
        ((eq? (car  nexp) '+) (+ (value-prefix(car(cdr nexp)))(value-prefix (car(cdr(cdr nexp))))))
        ((eq? (car  nexp) 'x) (x (value-prefix(car(cdr nexp)))(value-prefix (car(cdr(cdr nexp))))))
        (else (^ (value-prefix(car(cdr nexp)))(value-prefix (car(cdr(cdr nexp))))))
    )))
;前缀表达式
(define 1st-sub-exp
 (lambda (aexp)
   (car (cdr aexp))))
(define 2nd-sub-exp
 (lambda (aexp)
   (car (cdr (cdr aexp)))))
(define  operator
 (lambda (aexp)
   (car aexp)))
(define value-change
(lambda(nexp)
    (cond
        ((atom? nexp) nexp)
        ((eq? (operator  nexp) '+) (+ (value-change(1st-sub-exp nexp))(value-change (2nd-sub-exp nexp))))
        ((eq? (operator  nexp) 'x) (x (value-change(1st-sub-exp nexp))(value-change (2nd-sub-exp nexp))))
        (else (^ (value-change(1st-sub-exp nexp))(value-change (2nd-sub-exp nexp))))
    )))
(println(value-change 13))                          ; 13
(println(value-change '(+ 3 4)))                    ; 7
(println(value-change '(+ 1 (^ 3 4))))              ; 82
(println(value-change '(x (+ 1 (^ 3 4)) 2)))        ; 164
;中缀表达式
;重定义1st-sub-exp 和 operator
(define 1st-sub-exp
 (lambda (aexp)
   (car  aexp)))
(define  operator
 (lambda (aexp)
   (car (cdr aexp))))
;重定义操作之后可以使用中缀使
(println(value-change 13))                         ; 13
(println(value-change '(1 + 3)))                   ; 4
(println(value-change '(1 + (3 ^ 4))))             ; 82
(println(value-change '((1 + (3 ^ 4)) x 2)))       ; 164