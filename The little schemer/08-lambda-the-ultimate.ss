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

(println(subst-g 
  'topping
  'fudge
  '(ice cream with fudge for dessert))) ; '(ice cream with topping for dessert)

(println(yyy
  'sausage
  '(pizza with sausage and bacon)))      ; '(pizza with and bacon)

(println(value-a 13))                                 ; 13
(println(value-a '(+ 1 3)))                           ; 4
(println(value-a '(+ 1 (^ 3 4))))                     ; 82

(println((multirember-f eq?) 'tuna '(shrimp salad tuna salad and tuna)));'(shrimp salad salad and)
(println((multiremberT eq?-tuna) '(shrimp salad tuna salad and tuna)));(shrimp salad salad and)

(println(multiremember&co
  'tuna
  '(strawberries tuna and swordfish)
  a-friend)); #f

(println(multiremember&co
  'tuna
  '(strawberries tuna and swordfish)
  last-friend)); 3

(multiinsertLR&co
  'salty
  'fish
  'chips
  '(chips and fish or fish and chips)
  colImp);(chips salty and salty fish or salty fish and chips salty)2 2

(println(evens-only* even? '((9 1 2 8) 3 10 ((9 9) 7 6) 2)));((9 1) 3 ((9 9) 7))
(println(evens-only* uneven? '((9 1 2 8) 3 10 ((9 9) 7 6) 2)));((2 8) 10 (() 6) 2)

(evens-only*&co 
  uneven?
  '((9 1 2 8) 3 10 ((9 9) 7 6) 2)
  colImp);((2 8) 10 (() 6) 2)15309 28
(evens-only*&co 
  even?
  '((9 1 2 8) 3 10 ((9 9) 7 6) 2)
  colImp);((9 1) 3 ((9 9) 7))1920 38