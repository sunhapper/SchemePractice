;1.2
(/ (+ 5 4 (- 2(- 3 (+ 6 (/ 4 5)))))(* 3 (- 6 2) (- 2 7)))
;1.3
(define (bigger x y)
    (if (> x y)
        x
        y))
(define (smaller x y)
    (if (> x y)
        y
        x))
(define (bigger-sum-of x y z)
    (+ (bigger x y)(bigger (smaller x y) z)))

;1.4
(define (a-plus-abs-b a b)
    ((if (> b 0) + -) a b));将+/-作为函数与参数结合

;1.5
(define (p) (p))
(define (test x y)
    (if (= x 0)
        0
        y))
(test 0 (p));应用序会一直求(p),陷入无限循环;正则序可以返回(p)
;牛顿迭代法
(define (sqrt-iter guess x)
    (if (good-enough? guess x)
            guess
            (sqrt-iter (improve guess x)x)))
(define (average x y)
    (/ (+ x y) 2))
(define (improve guess x)
    (average guess (/ x guess)))
(define (good-enough? guess x)
    (<(abs (- (square guess) x)) 0.001))
(define (square x)
  (* x x))
(define (sqrt x)
    (sqrt-iter 1.0 x))
;1.6
(define (new-if predicate then-clause else-clause)
    (cond (predicate then-clause)
          (else else-clause)))
(define (sqrt-iter guess x)
    (new-if (good-enough? guess x)          ; <-- new-if 在这里,new-if是一个函数,所以在调用时就会求值,引起栈溢出
            guess
            (sqrt-iter (improve guess x)
                        x)))
;使用if和cond都不会对为false的分支进行求值
(define (sqrt-iter guess x)
    (cond
      ((good-enough? guess x) guess)
      (else      (sqrt-iter (improve guess x)x))))
;1.7 对较大的数和较小的数都可以获得相对精确的结果
(define (sqrt-iter guess x)
    (if (good-enough? guess (improve guess x))
            guess
            (sqrt-iter (improve guess x)x)))
(define (good-enough? old-guess new-guess)
    (> 0.01
       (/ (abs (- new-guess old-guess))
          old-guess)))