(include "common.ss")
(include "math.ss")
(println(add1 6));7
(println(sub1 6));5
(println(zero? 0));#t
(println(+ 12 34));46
(println(- 12 5));7
(println(addtup '(3 5 2 8)));18
(println(x 5 3));15
(println(x 13 4));52
(println(tup+ '(3 6 9 11 4) '(8 5 2 0 7)) )  ;  (11 11 11 11 11)
(println(tup+ '(3 7) '(4 6 8 1)));(7 13 8 1)
(println(> 12 133));#f 
(println(< 12 133));#t
(println(= 12 133));#f 
(println(<= 12 133));#t
(println(>= 12 133));#f 
(println(> 120 11));#t
(println(< 120 11));#f
(println(= 120 11));#f
(println(>= 120 11));#t
(println(<= 120 11));#f
(println(> 6 6));#f
(println(< 6 6));#f
(println(= 6 6));#t
(println(>= 6 6));#t
(println(<= 6 6));#t
(println(^ 2 4));16
(println(/ 15 4)); 3
(println(length '(hotdogs with mustard sauerkraut and pickles)));6
(println(pick 4 '(lasagna spaghetti ravioli macaroni meatball)));macaroni
(println(rempick 4 '(lasagna spaghetti ravioli macaroni meatball)));(lasagna spaghetti ravioli meatball)
(println(no-nums '(5 pears 6 prunes 9 dates)));(pears prunes dates)
(println(all-numbs '(5 pears 6 prunes 9 dates)));(5 6 9)
(println(occur 'x '(a b x x c d x)))     ; 3
(println(occur 'x '()) )                 ; 0
(println(one? 5))        ; #f
(println(one? 1))        ; #t