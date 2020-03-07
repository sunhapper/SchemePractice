;atom？ 参数是一个S表达式，判断是不是原子
(define atom?
(lambda (s)
(and (not(pair? s))(not (null? s)))))

;lat? 参数是一个list，判断所有元素是不是都是原子
(define lat?
(lambda (lat)
(cond
    ((null? lat) #t)
    ((atom? (car lat)) (lat? (cdr lat)))
    (else #f))))

;member? 参数是一个s表达式和一个list,判断s表达式是不是list的元素  
(define member?
(lambda (a lat)
(cond
    ((null? lat) #f)
    ((eq? a (car lat)) #t)
    (else (member? a (cdr lat))))))

;println 结尾换行的display
(define println
(lambda (a)
(display a)(newline)
)
)