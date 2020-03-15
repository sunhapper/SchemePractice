(include "common.ss")
(include "friend.ss")
(define looking
    (lambda (a lat)
        (keep-looking a (pick 1 lat) lat)))
(define keep-looking;非自然递归
    (lambda (a i lat)
        (cond
            ((number? i) (keep-looking a (pick i lat) lat))
            (else (equal? a i)))
    ))
(define eternity;partial function 偏函数 对应 total function
  (lambda (x)
    (eternity x)))

(define shift
  (lambda (pair)
    (build 
      (first (first pair))
      (build (second (first pair))(second pair))
        )))
(define align
  (lambda (pora)
    (cond
      ((atom? pora) pora)
      ((a-pair? (first pora))
       (align (shift pora)))
      (else (build (first pora)
              (align (second pora)))))))
(define length*
  (lambda (pora)
    (cond
      ((atom? pora) 1)
      (else
        (+ (length* (first pora))
           (length* (second pora)))))))

(define weight*
  (lambda (pora)
    (cond
      ((atom? pora) 1)
      (else
        (+ (* (weight* (first pora)) 2)
           (weight* (second pora)))))))

(define shuffle
  (lambda (pora)
    (cond
      ((atom? pora) pora)
      ((a-pair? (first pora))
       (shuffle (revpair pora)))
      (else
        (build (first pora)
          (shuffle (second pora)))))))

;克拉茨猜想 不是全函数
(define C
  (lambda (n)
    (cond
      ((one? n) 1)
      (else
        (cond
          ((even? n) (C (/ n 2)))
          (else
            (C (add1 (* 3 n)))))))))
;阿克曼函数
(define A
  (lambda (n m)
    (cond
      ((zero? n) (add1 m))
      ((zero? m) (A (sub1 n) 1))
      (else
        (A (sub1 n)
           (A n (sub1 m)))))))

;停机问题
; (define will-stop?
;     (lambda (f)
;         ...))
; (define last-try
;   (lambda (x)
;     (and (will-stop? last-try) (eternity x))));eternity是一个永远不会停止的函数

; length0
;
(lambda (l)
  (cond
    ((null? l) 0)
    (else
      (add1 (eternity (cdr l))))))

; length<=1
;
(lambda (l)
  (cond
    ((null? l) 0)
    (else
      (add1
        ((lambda(l)
           (cond
             ((null? l) 0)
             (else
               (add1 (eternity (cdr l))))))
         (cdr l))))))

; rewrite length0
;传入一个函数eternity
((lambda (length)
   (lambda (l)
     (cond
       ((null? l) 0)
       (else (add1 (length (cdr l)))))))
    eternity
)

; rewrite length<=1
;
((lambda (f)
   (lambda (l)
     (cond
       ((null? l) 0)
       (else (add1 (f (cdr l)))))));将length0作为参数,下面是length0的展开
 ((lambda (g)
    (lambda (l)
      (cond
        ((null? l) 0)
        (else (add1 (g (cdr l)))))))
  eternity))

; make length 传入一个length函数,返回一个类似length的函数
; length0
((lambda (mk-length)
  (mk-length eternity));mk-length参数是一个函数,传入了一个length函数
(lambda (length)
  (lambda (l)
    (cond
      ((null? l) 0)
      (else (add1 (length (cdr l))))))))

; rewrite length<=1
((lambda (mk-length)
   (mk-length
    (mk-length eternity)))
 (lambda (length)
   (lambda (l)
     (cond
       ((null? l) 0)
       (else (add1 (length (cdr l))))))))

; rewrite length<=2
((lambda (mk-length)
   (mk-length
    (mk-length 
     (mk-length eternity))))
 (lambda (length)
   (lambda (l)
     (cond
       ((null? l) 0)
       (else (add1 (length (cdr l))))))))
;最后调用((mk-length eternity) l)时会发现只能计算空list长度  
;所以将mk-length替换eternity拖延一下,因为mk-length可以接收任何函数
;length0
((lambda (mk-length)
  (mk-length mk-length))
 (lambda (length)
    (lambda (l)
      (cond
        ((null? l) 0)
        (else (add1
                (length (cdr l))))))))
;使用mk-length替换length,因为名字是等价的
(println(((lambda (mk-length)
  (mk-length mk-length))
 (lambda (mk-length);此时的mk-length只能处理空列表
    (lambda (l)
      (cond
        ((null? l) 0)
        (else (add1
                (mk-length (cdr l)))))))) '()))
;length<=1
((lambda (mk-length)
  (mk-length mk-length))
 (lambda (mk-length)
    (lambda (l)
      (cond
        ((null? l) 0)
        (else (add1
                ((mk-length eternity)(cdr l))))))))
;如果将mk-length传给mk-length,想怎么重复调用就怎么重复调用
((lambda (mk-length)
  (mk-length mk-length))
 (lambda (mk-length)
    (lambda (l)
      (cond
        ((null? l) 0)
        (else (add1
                ((mk-length mk-length)(cdr l))))))))
;不存在length类似的函数了,但是(mk-length mk-length)实现了length的功能
;将(mk-length mk-length)代换为length
((lambda (mk-length)
   (mk-length mk-length))
 (lambda (mk-length)
   ((lambda (length)
      (lambda (l)
        (cond
          ((null? l) 0)
          (else (add1 (length (cdr l)))))))
    (mk-length mk-length))));(mk-length mk-length)作为length的参数传入
;此时会对(mk-length mk-length)不断进行展开
((lambda (mk-length)
   ((lambda (length)
      (lambda (l)
        (cond
          ((null? l) 0)
          (else (add1 (length (cdr l)))))))
    (mk-length mk-length)))
 ;这部分是参数
 (lambda (mk-length)
   ((lambda (length)
      (lambda (l)
        (cond
          ((null? l) 0)
          (else (add1 (length (cdr l)))))))
    (mk-length mk-length))))
;为了让(mk-length mk-length)避免死循环,将(mk-length mk-length)改造为一个函数
((lambda (mk-length)
 (mk-length mk-length))
(lambda (mk-length)
   (lambda (l)
     (cond
       ((null? l) 0)
       (else (add1
              ((lambda (x)
               ((mk-length mk-length) x)) (cdr l))))))))
;将(lambda (x)((mk-length mk-length) x))作为参数
((lambda (mk-length)
  (mk-length mk-length))
(lambda (mk-length)
  ((lambda (length);参数(lambda (x)((mk-length mk-length) x))
     (lambda (l)
       (cond
         ((null? l) 0)
         (else (add1
                (length (cdr l)))))))
   (lambda (x)
     ((mk-length mk-length) x)))))
;此时length与mk-length无关,提取length  
((lambda (le);参数为length的定义
   ((lambda (mk-length)
      (mk-length mk-length))
    (lambda (mk-length)
      (le (lambda (x)
            ((mk-length mk-length) x))))))
 (lambda (length)
   (lambda (l)
     (cond
      ((null? l) 0)
      (else (add1 (length (cdr l))))))))
;Y combinator 
(define Y
 (lambda (le)
   ((lambda (f) (f f))
    (lambda (f)
      (le (lambda (x) ((f f) x)))))))