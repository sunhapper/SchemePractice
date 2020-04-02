(define (square x)
  (* x x))
;素数检测 √n
(define (divides? a b)
    (= (remainder b a) 0))
(define (samllest-divisor n)
    (define (find-divisor n test-divisor)
        (cond
            ((> (square test-divisor) n) n);如果n不是素数,必然有一个小于或等于√n的因子
            ((divides? test-divisor n) test-divisor)
            (else (find-divisor n (+ test-divisor 1)))
            ))
    (find-divisor n 2))
(define (prime? n)
    (= n (samllest-divisor n)))
;素数检测 logn 费马小定理 如果n是一个素数,a是小于n的任意正整数,那么a的n次方与a模n同余
;expmod不使用fast-expt 是因为先计算乘方会造成数特别大
(define (expmod base exp m)
    (cond ((= exp 0)
            1)
          ((even? exp)
            (remainder (square (expmod base (/ exp 2) m));(a * b) % p = (a % p * b % p) % p
                       m))
          (else
            ; (a * b % p) % p
            ; =(a % p * (b % p) %p) % p
            ; =(a % p * b % p) % p
            ; =(a * b ) % p
            ;(a * b ) % p=(a * b % p) % p
            (remainder (* base (expmod base (- exp 1) m))
                       m))))
(define (fermat-test n)
    (define (try-it a)
        (= (expmod a n n) a))
    (try-it (+ 1 (random (- n 1)))))
 
(define (fast-prime? n times)
    (cond ((= times 0)
            #t)
          ((fermat-test n)
            (fast-prime? n (- times 1)))
          (else #f)))
;1.22 没找到chez的runtime方法
(define (next-odd n)
    (if (odd? n)
        (+ 2 n)
        (+ 1 n)))
(define (continue-primes n count)
    (cond ((= count 0)
            (display "are primes."))
          ((prime? n)
            (display n)
            (newline)
            (continue-primes (next-odd n) (- count 1)))
          (else
            (continue-primes (next-odd n) count))))
(time(continue-primes 1000 10));0.000055002s
(time(continue-primes 10000 10));0.000049584s
(time(continue-primes 100000 10));0.000172738s
(time(continue-primes 1000000 10));0.000230131s
;1.23
(define (next n)
    (if (= n 2)
        3
        (+ n 2)))
(define (samllest-divisor n)
    (define (find-divisor n test-divisor)
        (cond
            ((> (square test-divisor) n) n);如果n不是素数,必然有一个小于或等于√n的因子
            ((divides? test-divisor n) test-divisor)
            (else (find-divisor n (next test-divisor)))
            ))
    (find-divisor n 2))
(time(continue-primes 1000 10));0.000051741s
(time(continue-primes 10000 10));0.000050343s
(time(continue-primes 100000 10));0.000073412s
(time(continue-primes 1000000 10));0.000182057s

;1.28 Miller-Rabin检查 
(define (expmod base exp m)
    (cond ((= exp 0)
            1)
          ((nontrivial-square-root? base m)0)                                              
          ((even? exp)
            (remainder (square (expmod base (/ exp 2) m))
                       m))
          (else
            (remainder (* base (expmod base (- exp 1) m))
                       m))))
(define (nontrivial-square-root? a n)
    (and (not (= a 1))
         (not (= a (- n 1)))
         (= 1 (remainder (square a) n))))
(define (non-zero-random n)
    (let ((r (random n)))
        (if (not (= r 0))
            r
            (non-zero-random n))))
(define (Miller-Rabin-test n)
    (define (test-iter n times)
        (cond ((= times 0)
            #t)
          ((= (expmod (non-zero-random n) (- n 1) n)
              1)
            (test-iter n (- times 1)))
          (else
            #f)))
    (let ((times (ceiling (/ n 2))))
        (test-iter n times)))
