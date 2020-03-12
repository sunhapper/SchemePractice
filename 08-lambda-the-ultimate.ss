(include "ultimate.ss")
(println(rember-f eq? 2 '(1 2 3 4 5)));(1 3 4 5)
(println(rember-f equal? '(2 3) '(1 (2 3) 4 5)));(1 4 5)

(println((eq?-c 'tuna) 'tuna))       ; #t
(println((eq?-c 'tuna) 'salad))      ; #f
(println(eq?-salad 'salad))          ; #t
(println(eq?-salad 'tuna))           ; #f

(println((f-rember eq?) 2 '(1 2 3 4 5)));(1 3 4 5)
(println((insertL-f eq?)
  'd
  'e
  '(a b c e f g d h)))                  ; '(a b c d e f g d h)

(println((insertR-f eq?)
  'e
  'd
  '(a b c d f g d h)))                  ; '(a b c d e f g d h)

(println(insert-g-l
  'd
  'e
  '(a b c e f g d h)))                  ; '(a b c d e f g d h)
(println(insert-g-r
  'd
  'e
  '(a b c e f g d h)))                  ; '(a b c e d f g d h)