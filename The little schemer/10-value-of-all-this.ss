(include "common.ss")
;entry 是由 list 组成的 pair ， pair 的第一个 list 是 set 。另外，两个 list 的长度必须是相同的
(define build
  (lambda (s1 s2)
    (cons s1 (cons s2 '()))))
(define new-entry build)

(define first
  (lambda (p)
    (car p)))

(define second
  (lambda (p)
    (car (cdr p))))
(define third
  (lambda (l)
    (car (cdr (cdr l)))))
(define lookup-in-entry
  (lambda (name entry entry-f)
    (lookup-in-entry-help
      name
      (first entry)
      (second entry)
      entry-f)))

(define lookup-in-entry-help
  (lambda (name names values entry-f)
    (cond
      ((null? names) (entry-f name))
      ((eq? (car names) name) (car values))
      (else
        (lookup-in-entry-help
          name
          (cdr names)
          (cdr values)
          entry-f)))))
;table entry组成的list
(define extend-table cons)
(define lookup-in-table
 (lambda (name table table-f)
   (cond
     ((null? table) (table-f name))
     (else (lookup-in-entry name
                            (car table)
                            (lambda (name)
                              (lookup-in-table name (cdr table) table-f)))))))
; 我们找到六种类型: 
; *const : 6 #f cons
; *quote : 'a 'nothing 
; *identifier : nothing
; *lambda : (lambda (x y) (cons x y))
; *cond : (cond(nothing (quote something))(else (quote nothing)))
; *application  : ((lambda (nothing)(cond(nothing (quote something))(else (quote nothing))))#t)    


(define atom-to-action
  (lambda (e)
    (cond
      ((number? e) *const)
      ((eq? e #t) *const)
      ((eq? e #f) *const)
      ((eq? e (quote cons)) *const)
      ((eq? e (quote car)) *const)
      ((eq? e (quote cdr)) *const)
      ((eq? e (quote null?)) *const)
      ((eq? e (quote eq?)) *const)
      ((eq? e (quote atom?)) *const)
      ((eq? e (quote zero?)) *const)
      ((eq? e (quote add1)) *const)
      ((eq? e (quote sub1)) *const)
      ((eq? e (quote number?)) *const)
      (else *identifier))))
(define list-to-action
  (lambda (e)
    (cond
      ((atom? (car e))
       (cond
         ((eq? (car e) (quote quote)) *quote)
         ((eq? (car e) (quote lambda)) *lambda)
         ((eq? (car e) (quote cond)) *cond)
         (else *application)))
      (else *application))))
;s-表达式的类型
(define expression-to-action
  (lambda (e)
    (cond
      ((atom? e) (atom-to-action e))
      (else (list-to-action e)))))   
(define value
  (lambda (e)
    (meaning e (quote ()))))

;table用来存储数据
;执行action
(define meaning
  (lambda (e table)
    ((expression-to-action e) e table)))           

(define *const
  (lambda (e table)
    (cond
      ((number? e) e)
      ((eq? e #t) #t)
      ((eq? e #f) #f)
      (else (build 'primitive e))))) 
;只能识别出(quote xxx),不能识别出'
(define *quote
  (lambda (e table)
    (text-of e)))
(define text-of second)
;标识符,在table中查找标识符对应的元素 ,如果e为空则抛异常
(define *identifier
  (lambda (e table)
    (lookup-in-table e table initial-table)))
;lookup-in-table 的第三个参数是用来处理某个name对应是空表的情况，这时table是有问题的，table本来是给出identifier标识符的对应值的。没有给出identifier的值，于是直接抛出一个错误了，(car (quote))是违反primitive 的car操作定义的
(define initial-table
  (lambda (name)
    (car (quote ()))))
(define *lambda
  (lambda (e table)
    (build (quote non-primitive)
      (cons table (cdr e)))))

(define table-of first)
(define formals-of second)
(define body-of third)

(define evcon
  (lambda (lines table)
    (cond
      ;是else 执行答案
      ;是问题 执行判断问题的值,为#t再执行答案
      ;否则取lines的cdr进行递归 因为car lines不会被执行了
     ((else? (question-of (car lines)))
      (meaning (answer-of (car lines))
               table))
     ((meaning (question-of (car lines))
               table)
      (meaning (answer-of (car lines))
               table))
     (else (evcon (cdr lines) table)))))
(define else?
  (lambda (x)
    (cond
      ((atom? x) (eq? x (quote else)))
      (else #f))))

(define question-of first)

(define answer-of second)

(define *cond
  (lambda (e table)
    (evcon (cond-lines-of e) table)))
(define cond-lines-of cdr)

(define evlis
  (lambda (args table)
    (cond
      ((null? args) '())
      (else
        (cons (meaning (car args) table)
              (evlis (cdr args) table))))))

(define *application
  (lambda (e table)
    (applyz
      (meaning (function-of e) table)
      (evlis (arguments-of e) table))))

(define function-of car)
(define arguments-of cdr)

(define primitive?
  (lambda (l)
    (eq? (first l) 'primitive)))

(define non-primitive?
  (lambda (l)
    (eq? (first l) 'non-primitive)))

(define applyz
  (lambda (fun vals)
    (cond
      ((primitive? fun)
       (apply-primitive (second fun) vals))
      ((non-primitive? fun)
       (apply-closure (second fun) vals)))))
(define apply-primitive
  (lambda (name vals)
    (cond
      ((eq? name 'cons)
       (cons (first vals) (second vals)))
      ((eq? name 'car)
       (car (first vals)))
      ((eq? name 'cdr)
       (cdr (first vals)))
      ((eq? name 'null?)
       (null? (first vals)))
      ((eq? name 'eq?)
       (eq? (first vals) (second vals)))
      ((eq? name 'atom?)
       (:atom? (first vals)))
      ((eq? name 'zero?)
       (zero? (first vals)))
      ((eq? name 'add1)
       (+ 1 (first vals)))
      ((eq? name 'sub1)
       (- 1 (first vals)))
      ((eq? name 'number?)
       (number? (first vals))))))

(define :atom?
  (lambda (x)
    (cond
      ((atom? x) #t)
      ((null? x) #f)
      ((eq? (car x) 'primitive) #t)
      ((eq? (car x) 'non-primitive) #t)
      (else #f))))

(define apply-closure
  (lambda (closure vals)
    (meaning
      (body-of closure)
      (extend-table ;table用来保存多个lambda的参数
                    (new-entry;new-entry将lambda的形参和实参绑定,构成一个entry
                      (formals-of closure)
                      vals)
                    (table-of closure)))))
(value '(add1 6))                           ; 7
(value '(quote (a b c)))                    ; '(a b c)
(value '(car (quote (a b c))))              ; 'a
(value '(cdr (quote (a b c))))              ; '(b c)
(value
  '((lambda (x)
      (cons x (quote ())))
    (quote (foo bar baz))))                 ; '((foo bar baz))
;(meaning e '()))
;((expression-to-action e) e '())
;((list-to-action e)e '())
;list-to-action e -> *application
;*application e '()
;(apply(meaning (function-of e) '())(evlis (arguments-of e) '()))
;分
;(meaning (function-of e) '())
;(meaning (lambda (x)(cons x (quote ()))) '())
;(*lambda (lambda (x)(cons x (quote ()))) '())
;(non-primitive  ((quote ()) (x) (cons x (quote ()))))
;合
;(apply(non-primitive  ((quote ()) (x) (cons x (quote ()))))(evlis (arguments-of e) table))
;分
;(evlis (arguments-of e) table)
;(evlis ((quote (foo bar baz))) '())
;(cons (meaning (car args) '())'())
;(cons (meaning (quote (foo bar baz)) '())'())
;(cons (*quote (quote (foo bar baz)) '()) '())
;(cons (foo bar baz) '())
;((foo bar baz))
; 合
; (apply(non-primitive  ((quote ()) (x) (cons x (quote ()))))((foo bar baz)))
; (apply-closure  ((quote ()) (x) (cons x (quote ()))) ((foo bar baz)))
; (meaning (cons x (quote ())) (extend-table(new-entry (x) ((foo bar baz)))'()))
; (meaning (cons x (quote ())) (extend-table ((x) ((foo bar baz)))'()))
; (meaning (cons x (quote ())) (((x) ((foo bar baz)))))
; (meaning (x) (((x) ((foo bar baz)))))
; (*identifier (x) (((x) ((foo bar baz)))))
; (lookup-in-table (x) (((x) ((foo bar baz)))) initial-table)
; (lookup-in-entry (x) ((x) ((foo bar baz))) initial-table)
; (foo bar baz)

(value
  '((lambda (x)
      (cond
        (x (quote true))
        (else
          (quote false))))
    #t)) 
;(meaning e '()))
;(*application e '())
;(apply(meaning (lambda (x)(cond(x  'true)(else  'false))) '()) (#t))
;(apply (*lambda (lambda (x)(cond(x  'true)(else  'false))) '()) (#t))
;(apply ('non-primitive ('() (x)(cond(x  'true)(else  'false)))) (#t))
;(apply-closure ('() (x)(cond(x  'true)(else  'false))) (#t))
;(apply-closure ('() (x)(cond(x  'true)(else  'false))) (#t))
;(meaning (cond(x  'true)(else  'false)) (((x)((#t)))))
;(*cond (cond(x  'true)(else  'false)) (((x)((#t)))))
; evcon 参数为多个q-a pair
;(evcon ((x  'true)(else  'false)) (((x)((#t)))))
;先询问else作为终止条件 ,再询问第一个q,递归evcon问下一个问题
;(cond ((meaning x) (meaning 'true)))
;(cond (#t 'true))
;'true