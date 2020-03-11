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

