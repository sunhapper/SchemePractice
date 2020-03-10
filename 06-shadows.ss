(include "shadow.ss")
(println(numbered? '5))                               ; #t
(println(numbered? '(5 o+ 5)) )                       ; #t
(println(numbered? '(5 ox (3 o^ 2))) )                ; #t
(println(numbered? '((5 o+ 2) ox (3 o^ 2))) )         ; #t

(println(value 13))                         ; 13
(println(value '(1 + 3)))                   ; 4
(println(value '(1 + (3 ^ 4))))             ; 82
(println(value '((1 + (3 ^ 4)) x 2)))       ; 164

(println(value-prefix 13))                          ; 13
(println(value-prefix '(+ 3 4)))                    ; 7
(println(value-prefix '(+ 1 (^ 3 4))))              ; 82
(println(value-prefix '(x (+ 1 (^ 3 4)) 2)))        ; 164
(println(adds '(()) '(() ())))     ; (+ 1 2)
;==> '(() () ())
(println(tat? '((()) (()()) (()()()))))  ; (lat? '(1 2 3))
; ==> #f is shadow 更高层次的抽象面临的风险也更高