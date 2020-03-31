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
;递归
(define (fun-f n)
    (cond
        ((< n 3) n)
        (else (+(fun-f (- n 1)) 
                (* 2 (fun-f (- n 2)))
                (* 3 (fun-f (- n 3)))))))
;迭代
(define (fun-f-iter a b c i count);i指向的是a的位置,如i=1时值为1
    (define (jisuan a b c)
        (+ (* 3 a) (* 2 b) c))
        (cond
            ((< count 3) count)
            ((= i count) a)
            (else (fun-f-iter b c (jisuan a b c) (+ 1 i) count))    
        ))
(define (fun-f n)
    (fun-f-iter 0 1 2 0 n))
;1.12
;递归
(define (pascal row col)
    (cond
        ((= col 0) 1) 
        ((= col row) 1)
        (else (+(pascal (- row 1) col)(pascal (- row 1)(- col 1))))))
;迭代,根据pascal(row col)=row!/(col!*(row-col)!)
;计算阶乘
(define (factorial n)
    (define (factorial-iter n sum)
        (cond
            ((= n 0) sum)
            (else (factorial-iter (- n 1) (* n sum)))))
    (factorial-iter n 1))
(define (pascal row col)
    (/ (factorial row)
       (* (factorial col)
          (factorial (- row col)))))
(pascal 1024 256)
