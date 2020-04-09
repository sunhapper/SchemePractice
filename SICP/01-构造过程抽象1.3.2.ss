;使用局部命名过程
(define (f x y)
  (define (f-helper a b)
    (+ (* x (square a))(* y b)(* a b)))
  (f-helper 
    (+ 1 (* x y));参数a
    (- 1 y);参数b
  ))
;等价为lambda的形式
(define (f x y)
  ((lambda (a b)
    (+ (* x (square a))(* y b)(* a b)))
      (+ 1 (* x y));参数a
      (- 1 y);参数b
  ))
;使用let的形式
(define (f x y)
  (let ((a  (+ 1 (* x y)))(b (- 1 y)))
    (+ (* x (square a))(* y b)(* a b))
  ))
;let的作用域-变量
(define (test-x x)
  (+ (let ((x 3))x);let表达式描述的变量的作用域只在于let的body,这里x是3
    x;这里的x是5
  ))
(display (test-x 5));8
;let的作用域-表达式
(define (test-x x)
 (let((x 3)
      (y (+ x 2)));let表达式是在let之外计算的,这里的x是参数x的值
    (* x y)))
(display (test-x 2));let中x为3 y为4
; (define (test-x)
;  (let((x 3)
;       (y (+ x 2)));variable x is not bound
;     (* x y)))
(define (f g)
  (g 2))
(f square);4
(f (lambda (z) (* z (+ z 1))));6
(f f)
(f f)
(f (lambda (g)
       (g 2)))
((lambda (g)
     (g 2))
 (lambda (g)
     (g 2)))
((lambda (g)
    (g 2))
 2);将第二个lambda带入第一个lambda的参数g
(2 2);将2带入lambda的参数g