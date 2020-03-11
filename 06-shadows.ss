(include "shadow.ss")
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

(println(numbered? '5))                               ; #t
(println(numbered? '(5 + 5)) )                       ; #t
(println(numbered? '(5 x (3 ^ 2))) )                ; #t
(println(numbered? '((5 + 2) x (3 ^ 2))) )         ; #t

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
(println(value 13))                         ; 13
(println(value '(1 + 3)))                   ; 4
(println(value '(1 + (3 ^ 4))))             ; 82
(println(value '((1 + (3 ^ 4)) x 2)))       ; 164

;value-prefix 计算前缀算数表达式的值
(define value-prefix
(lambda(nexp)
    (cond
        ((atom? nexp) nexp)
        ((eq? (car  nexp) '+) (+ (value-prefix(car(cdr nexp)))(value-prefix (car(cdr(cdr nexp))))))
        ((eq? (car  nexp) 'x) (x (value-prefix(car(cdr nexp)))(value-prefix (car(cdr(cdr nexp))))))
        (else (^ (value-prefix(car(cdr nexp)))(value-prefix (car(cdr(cdr nexp))))))
    )))
(println(value-prefix 13))                          ; 13
(println(value-prefix '(+ 3 4)))                    ; 7
(println(value-prefix '(+ 1 (^ 3 4))))              ; 82
(println(value-prefix '(x (+ 1 (^ 3 4)) 2)))        ; 164


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


(println(adds '(()) '(() ())))     ; (+ 1 2)
;==> '(() () ())
(println(tat? '((()) (()()) (()()()))))  ; (lat? '(1 2 3))
; ==> #f is shadow 更高层次的抽象面临的风险也更高