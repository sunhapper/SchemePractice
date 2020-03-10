(include "stars.ss")
(display(rember*
  'cup
  '((coffee) cup ((tea) cup) (and (hick)) cup)));((coffee) ((tea)) (and (hick)))

(println(insertR*
  'roast
  'chuck
  '((how much (wood)) could ((a (wood) chuck)) (((chuck)))
    (if (a) ((wood chuck))) could chuck wood)));((how much (wood)) could ((a (wood) chuck roast)) (((chuck roast))) (if (a) ((wood chuck roast))) could chuck roast wood)

(println(occur*
  'banana
  '((banana)
    (split ((((banana ice)))
            (cream (banana))
            sherbet))
    (banana)
    (bread)
    (banana brandy))));5

(println(subst*
  'orange
  'banana
  '((banana)
    (split ((((banana ice)))
            (cream (banana))
            sherbet))
    (banana)
    (bread)
    (banana brandy))));((orange) (split ((((orange ice))) (cream (orange)) sherbet)) (orange) (bread) (orange brandy))

(println(insertL*
  'pecker
  'chuck
  '((how much (wood)) could ((a (wood) chuck)) (((chuck)))
    (if (a) ((wood chuck))) could chuck wood)));((how much (wood)) could ((a (wood) pecker chuck)) (((pecker chuck))) (if (a) ((wood pecker chuck))) could pecker chuck wood)

(println(member*
  'chips
  '((potato) (chips ((with) fish) (chips))))) ; #t

(println(leftmost '((potato) (chips ((with) fish) (chips)))))    ; 'potato
(println(leftmost '(((hot) (tuna (and))) cheese)))               ; 'hot

(println(eqlist?
  '(strawberry ice cream)
  '(strawberry ice cream)) )                 ; #t

(println(eqlist?
  '(strawberry ice cream)
  '(strawberry cream ice)) )                 ; #f

(println(eqlist?
  '(banan ((split)))
  '((banana) split)) )                       ; #f

(println(eqlist?
  '(beef ((sausage)) (and (soda)))
  '(beef ((salami)) (and (soda)))) )         ; #f

(println(eqlist?
  '(beef ((sausage)) (and (soda)))
  '(beef ((sausage)) (and (soda))))  )       ; #t


(println(eqlist?
  '(beef ((sausage)) (and (soda)))
  '(beef ((sausage)) (and (soda))))  )       ; #t