(define (average x y)
    (/ (+ x y) 2))
(define (close-enough? x y)
  (< (abs (- x y)) 0.001))
(define (search f neg-point pos-point)
  (let ((midpoint (average neg-point pos-point)))
    (if (close-enough? neg-point pos-point)
      midpoint
      (let ((test-value (f midpoint)))
        (cond
          ((positive? test-value) (search f neg-point midpoint))
          ((negative? test-value) (search f midpoint pos-point))
          (else midpoint)
          )))))
;search 可能传入两个正负相同的点,
(define (half-interval-method f a b)
  (let ((a-value (f a))
        (b-value (f b)))
    (cond
      ((and (negative? a-value)(positive? b-value)) (search f a b))
      ((and (negative? b-value)(positive? a-value)) (search f b a))
      (else (error "Values are not of opposite sign" a b)))))
(half-interval-method sin 2.0 4.0);3.14111328125

;函数不动点 f(x)=x,x称为函数f的不动点
(define (fixed-point f first-guess)
  (define (try guess)
    (let ([next (f guess)])
      (if (close-enough? guess next)
        next
        (try next))))
  (try first-guess))
(fixed-point cos 1.0);0.7387603198742112 
(fixed-point (lambda (y) (+ (sin y)(cos y))) 1.0);1.2590038597400248
;计算x的平方根y^2=x,变换成y=x/y,寻找x的平方根就是找y=x/y的不动点
(define (sqrt x)
  (fixed-point (lambda (y)(/ x y)) 1.0));此搜寻是不收敛的
;为了使x/y不至于远离y,可以使用y和x/y的平均值作为下一个猜测值,这种技术叫平均阻尼
;y=x/y y+y=x/y+y y=1/2(y+x/y)
;平均阻尼 一个接收函数返回函数的高阶函数
(define (average-damp f)
    (lambda (x)
        (average x 
                 (f x))))
(define (sqrt x)
  (fixed-point (average-damp (lambda (y)(/ x y))) 1.0))
(sqrt 10);3.162277665175675

;黄金分割
(fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0);1.6181818181818182 x/1=1/(x-1)
(fixed-point (lambda (x) (/ 1 (+ 1 x)))1.0);0.6181818181818182 1/x=x/1-x
(define (fixed-point f first-guess)
  (define (try guess)
    (let ([next (f guess)])
      (display next)
      (newline)
      (if (close-enough? guess next)
        next
        (try next))))
  (try first-guess))
(fixed-point (lambda (x) (/ (log 1000)(log x)))2.0);4.555870396702851 22次
(fixed-point (average-damp (lambda (x) (/ (log 1000)(log x)))) 2.0);4.555870396702851 7次
;无穷连分式 递归版本
(define (cont-frac n d k)
  (define (cf i)
    (if (= i k)
      (/ (n k) (d k))
      (/(n i)(+(d i)(cf (+ i 1))))))
  (cf 1))
;迭代版本
(define (cont-frac n d k)
  (define (iter i result)
    (if (= i 0)
      result
      (iter (- i 1)(/ (n i)(+ (d i) result)))
    ))
  (iter (- k 1)(/(n k)(d k))))
(define (golden-ratio k)
    (+ 1
       (cont-frac (lambda (i) 1.0)
                  (lambda (i) 1.0)
                  k)))
(display(golden-ratio 10));1.6179775280898876