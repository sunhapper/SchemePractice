(include "common.ss")
(println(lat? '((Jack) Sprat could eat no chicken fat)));#f 

(println(lat? '()))

(println(lat? '(bacon and eggs)))

(println(member? 'meat '(mashed potatoes and meat gravy)))

(println(member? '(meat) '(mashed potatoes and (meat) gravy)));eq? '(a) '(a)的结果是未定义的

(println(member? 'meats '(mashed potatoes and meat gravy)))

(println(member? 'liver '()))