;1.29 辛普森规则  
;求和的模式
(define (sum a b term next)
  (if (> a b)
    0
    (+ (term a)(sum (next a) b term next))))
(define (sum-simpson a b n fun)
  (define h (/ (- b a)
    n))
  (define (y k)
    (fun (+ a (* k h))))
  (define (factor k)
    (cond
      ((or (= k 0)(= k n)) 1)
      ((even? k) 2)
      (else 4)))
  (define (term k)
    (* (factor k)(y k)))
  (define (next k)
    (+ k 1))
 (*(/ h 3)(sum 0 n term next)))
; 1.30 迭代过程的sum
(define (sum a b term next)
  (define (sum-iter a result)
  (if (> a b)
    result
    (sum-iter (next a)(+ result (term a)))
    ))
  (sum-iter a 0)
)
(define (cube x)
  (* x x))
(sum-simpson 0 1 100 cube)

;1.31 product 递归 
(define (product a b term next)
  (if (> a b)
    1
    (*(term a)(product (next a) b term next))
  ))
;迭代
(define (product a b term next)
  (define (iter a result)
    (if (> a b)
      result
      (iter (next a) (* (term a) result))))
  (iter a 1))
(define (factorial n)
  (product 1 n (lambda(x)x)(lambda(x)(+ x 1))))
(display (factorial 10))
(define (pi end)
  (define (term a)
    (if (even? a)
      (/ a (+ a 1))
      (/ (+ a 1) a)))
  (define (next a)
    (+ a 1))
  (* (product 2 end term next) 4))
(pi 100)

;1.32 accumulate 递归
(define (accumulate combiner null-value term a next b)
    (if (> a b)
        null-value
        (combiner (term a)
                  (accumulate combiner
                              null-value
                              term
                              (next a)
                              next
                              b))))
; 迭代
(define (accumulate combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
      result
      (iter (next a) (combiner (term a) result))))
  (iter a null-value))
(define (sum term a next b)
    (accumulate + 
                0 
                term 
                a 
                next 
                b))
(define (product term a next b)
    (accumulate *
                1 
                term
                a
                next
                b))