(include "common.ss")
(println(pair? 's));#f pair? 判断是否是点对

(println(pair? '(a . b)));#t 点对

(println(pair? '(a b c)));#t 非空列表是点对(list 是 pair构成的)

(println(pair? '()));#f 空列表不是是点对

(println(null? '()));#t 针对列表，判断是否为空列表

(println (null? '(a b c)));#f

(println (car '(a b c))) ;a 结果是S表达式，取非空列表/点对的首个元素

(println (cdr '(a b c))) ;(b c) 结果是列表，取非空列表排除首个元素之后的元素构成的列表；或者点对的后一个元素

(println (car '((a b c) x y z))) ;(a b c)

(println(car '(((hotdogs)) (and) (pickle) relish))); ((hotdogs))

(println(cons 'peanut '(butter and jelly)));(peanut butter and jelly) cons需要两个参数，第二个参数是list，将第一个参数添加到列表的头部，结果是list；

(println(cons 1 2)); (1 . 2) cons第二个参数是原子，则结果是一个pair 

(println(cons '(banana and) '(peanut butter and jelly))); '((banana and) peanut butter and jelly)

(println(atom? '(a b c)));

(println(atom? '(a . c)))

(println(eq? 10 10));#t eq? 判断两个原子是否相等

(println(eq? 'a 'b));#f

