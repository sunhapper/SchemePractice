(include "09-again-and-again.ss")
(println(looking 'caviar '(6 2 4 caviar 5 7 3)))        ; #t
(println(looking 'caviar '(6 2 grits caviar 5 7 3)))     ; #f
(println(shift '((a b) c)))                            ; '(a (b c))
(println(shift '((a b) (c d))))                        ; '(a (b (c d)))
(println(weight* '((a b) c)))                          ; 7
(println(weight* '(a (b c))))                          ; 5
(println(weight* '((a b) (c d))))                          ; 9
(println(weight* '(a (b (c d)))))                          ; 7
(println(shuffle '(a (b c))))                          ; '(a (b c))
(println(shuffle '(a b)))                              ; '(a b)
; (shuffle '((a b) (c d)));永不停止 