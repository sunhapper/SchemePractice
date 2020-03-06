(display(pair? 's));#f pair? 判断是否是点对
(newline)
(display(pair? '(a b c)));#t 非空列表是点对(list 是 pair构成的)
(newline)
(display(pair? '()));#f 空列表不是是点对
(newline)
(display(null? '()));#t 针对列表，判断是否为空列表
(newline)
(display (null? '(a b c)));#f
(newline)
(display (car '(a b c))) ;a 结果是S表达式，取非空列表/点对的首个元素
(newline)
(display (cdr '(a b c))) ;(b c) 结果是列表，取非空列表排除首个元素之后的元素构成的列表；或者点对的后一个元素
(newline)
(display (car '((a b c) x y z))) ;(a b c)
(newline)
(display(car '(((hotdogs)) (and) (pickle) relish))); ((hotdogs))
(newline)
(display(cons 'peanut '(butter and jelly)));(peanut butter and jelly) cons需要两个参数，第二个参数是list，将第一个参数添加到列表的头部，结果是list；
(newline)
(display(cons 1 2)); (1 . 2) cons第二个参数是原子，则结果是一个pair 
(newline)
(display(cons '(banana and) '(peanut butter and jelly))); '((banana and) peanut butter and jelly)
(newline)
(define atom?
(lambda (s)
(and (not(pair? s))(not (null? s)))));不是点对不是空列表则是原子
(display(atom? '(a b c)))