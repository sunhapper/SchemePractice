;欧几里得算法 是迭代过程
(define (gcd a b)
    (cond
        ((= b 0) a)
        (else gcd b (remainder a b))))