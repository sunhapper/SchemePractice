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
(display(sum-simpson 0 1 10000000 cube))