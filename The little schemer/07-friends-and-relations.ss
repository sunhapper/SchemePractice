(include "friend.ss")
(println(set? '(apples peaches pears plums)))            ; #t
(println(set? '(apple peaches apple plum)))              ; #f
(println(set? '(apple 3 pear 4 9 apple 3 4)))            ; #f
(println(set? '((apple 3) pear 4 9 (apple 3))))          ; #f
(println(set? '((apple 3) pear 4 9  apple (apple))))     ; #t
(println(makeset '(apple peach pear peach plum apple lemon peach))); ==> '(pear plum apple lemon peach)
(println(makeset '((apple peach) pear peach plum apple lemon peach (apple peach)))); ==> '(pear plum apple lemon peach (apple peach))
(println(makeset-multirember '(apple peach pear peach plum apple lemon peach))); ==> '(apple peach pear plum lemon)
(println(makeset-multirember '((apple peach) pear peach plum apple lemon peach (apple peach)))); ==> '((apple peach) pear peach plum apple lemon)

(println(subset? '(5 chicken wings)
         '(5 hamburgers 2 pieces fried chicken and light duckling wings)));#t
(println(subset? '(5 (chicken) wings)
         '(5 hamburgers 2 pieces fried chicken and light duckling wings)));#f
(println(subset? '(5 (chicken light) wings)
         '(5 hamburgers 2 pieces fried (chicken light) chicken and light duckling wings)));#t

(println(eqset? '(a b c) '(c b a)))          ; #t
(println(eqset? '() '()))                    ; #t
(println(eqset? '(a b c) '(a b)))            ; #f

(println(intersect?
  '(stewed tomatoes and macaroni)
  '(macaroni and cheese)));#t
(println(intersect?
  '(a b c)
  '(d e f)));#f

(println(intersect
  '(stewed tomatoes and macaroni)
  '(macaroni and cheese)));(and macaroni)

(println(union
  '(stewed tomatoes and macaroni casserole)
  '(macaroni and cheese)));(stewed tomatoes casserole macaroni and cheese)

(println(xxx '(a b c) '(a b d e f)))     ; '(c)

(println(intersectall '((a b c) (c a d e) (e f g h a b))))       ; '(a)
(println(intersectall
  '((6 pears and)
    (3 peaches and 6 peppers)
    (8 pears and 6 plums)
    (and 6 prunes with some apples))))                   ; '(6 and)

(println(a-pair? '(pear pear)))          ; #t
(println(a-pair? '(3 7)))                ; #t
(println(a-pair? '((2) (pair))))         ; #t
(println(a-pair? '(full (house))))       ; #t
(println(a-pair? '()))                   ; #f
(println(a-pair? '(a b c)))              ; #f
(println(fun? '((4 3) (4 2) (7 6) (6 2) (3 4))))     ; #f
(println(fun? '((8 3) (4 2) (7 6) (6 2) (3 4))))     ; #t
(println(fun? '((d 4) (b 0) (b 9) (e 5) (g 4))))     ; #f

(println(revrel '((8 a) (pumpkin pie) (got sick))));((a 8) (pie pumpkin) (sick got))

(println(fullfun? '((8 3) (4 2) (7 6) (6 2) (3 4))))     ; #f
(println(fullfun? '((8 3) (4 8) (7 6) (6 2) (3 4))))     ; #t
(println(fullfun? '((grape raisin)
            (plum prune)
            (stewed prune))))                    ; #f
(println(one-to-one? '((8 3) (4 2) (7 6) (6 2) (3 4))))     ; #f
(println(one-to-one? '((8 3) (4 8) (7 6) (6 2) (3 4))))     ; #t
(println(one-to-one? '((grape raisin)
            (plum prune)
            (stewed prune))))                    ; #f

