;求幂
;递归
(define (expt b n)
    (if (= n 0)
        1
        (* b (expt b (- n 1)))))
;迭代
(define (expt b n)
    (define (expt-iter b n sum)
        (if (= n 0)
            sum
            (expt-iter b (- n 1) (* sum b))))
    (expt-iter b n 1))
;logn的解法
;递归
(define (even? n)
    (= (remainder n 2) 0))
(define (fast-expt b n)
    (cond
        ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))
        ))
;1.16 迭代
(define (fast-expt b n)
    (define (fast-expt-iter b n sum)
        (cond
            ((= n 0) sum)
            ((even? n) (fast-expt-iter (* b b)(/ n 2) sum))
            (else (fast-expt-iter b (- n 1) (* sum b) ))))
    (fast-expt-iter b n 1))
(fast-expt 3 7)
;用+实现*
(define (double x)
    (* 2 x))
(define (halve x)
    (/ x 2))
(define (multiply a b)
    (if (= b 0)
        0
        (+ a (multiply a (- b 1)))))
;1.17
(define (fast-multiply a b)
    (cond
        ((= b 0) 0)
        ((even? b) (fast-multiply (double a) (halve b)))
        (else (+ a (fast-multiply a (- b 1))))
        ))
;1.18迭代
(define (fast-multiply a b)
    (define (fast-multiply-iter a b sum)
        (cond
            ((= b 0) sum)
            ((even? b) (fast-multiply-iter (double a) (halve b) sum))
            (else (fast-multiply-iter a (- b 1) (+ sum a)) )
            ))
    (fast-multiply-iter a b 0))