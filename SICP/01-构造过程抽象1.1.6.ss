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
