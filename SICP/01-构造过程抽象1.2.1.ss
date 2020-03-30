;1.9 
(define (plus a b)
    (if (= a 0)
        b
        (add1 (plus (sub1 a) b))))
; 线性递归计算过程
; (plus 3 5)
; (add1 (plus 2 5))
; (add1 (add1 (plus 1 5)))
; (add1 (add1 (add1 (plus 0 5))))
; (add1 (add1 (add1 5)))
; (add1 (add1 6))
; (add1 7)
; 8

(define (plus a b)
    (if (= a 0)
        b
        (plus (sub1 a) (add1 b))))
;线性迭代计算过程
; (plus 3 5)
; (plus 2 6)
; (plus 1 7)
; (plus 0 8)
; 8

; 1.10
(define (A x y)
    (cond ((= y 0) 0)
          ((= x 0)(* 2 y)) ;2n
          ((= y 1) 2) ; 2
          (else
            (A (- x 1)
               (A x (- y 1))))))
(A 1 10);1024
(A 2 4);65536
(A 3 3);65536
(define (f n) (A 0 n)) ;2n
(define (g n) (A 1 n)) ;2^n
(define (h n) (A 2 n)) ;2^2^2^2 n个2
; 换零钱  
(define (change-count amount)
    (cc amount 5))
(define (cc amount kinds-of-coins)
    (cond
        ((= amount 0) 1)
        ((< amount 0) 0)
        ((= kinds-of-coins 0) 0)
        (else (+(cc amount (sub1 kinds-of-coins))(cc (- amount (face-value kinds-of-coins))  kinds-of-coins))))
    )
(define (face-value kinds-of-coins)
    (cond
        ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))
;1.11