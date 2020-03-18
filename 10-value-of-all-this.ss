(include "common.ss")
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
(define expression-to-action
  (lambda (e)
    (cond
      ((atom? e) (atom-to-action e))
      (else (list-to-action e)))))   
(define value
  (lambda (e)
    (meaning e (quote ()))))

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
(define *quote
  (lambda (e table)
    (text-of e)))
(define text-of second)
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
      (extend-table (new-entry
                      (formals-of closure)
                      vals)
                    (table-of closure)))))
