(include "common.ss")
(println(rember 'mint '(lamb chops and mint flavored mint jelly))) ; '(lamb chops and flavored mint jelly)
(println(rember 'toast '(bacon lettuce and tomato)))               ; '(bacon lettuce and tomato)
(println(rember 'cup '(coffee cup tea cup and hick cup)))          ; '(coffee tea cup and hick cup)
(println(firsts '((apple peach pumpkin)
          (plum pear cherry)
          (grape raisin pea)
          (bean carrot eggplant)))  )
(println(firsts '(((five plums) four)
          (eleven green oranges)
          ((no) more)))   )         
(println(insertR
  'topping 'fudge
  '(ice cream with fudge for dessert))) ; '(ice cream with fudge topping for dessert)
(println(insertL
  'd
  'e
  '(a b c e g d h)))                    ; '(a b c d e g d h)
(println(subst
  'topping
  'fudge
  '(ice cream with fudge for dessert))) ; '(ice cream with topping for dessert)
(println (subst2
  'vanilla
  'chocolate
  'banana
  '(banana ice cream with chocolate topping))) ; '(vanilla ice cream with chocolate topping)
(println(multirember
  'cup
  '(coffee cup tea cup and hick cup)))    ; '(coffee tea and hick)
(println(multiinsertL
  'x
  'a
  '(a b c d e a a b)))  ; (x a b c d e x a x a b)
(println(multiinsertR
  'x
  'a
  '(a b c d e a a b)));(a x b c d e a x a x b)

(println(multisubst
  'x
  'a
  '(a b c d e a a b)))  ; (x b c d e x x b)