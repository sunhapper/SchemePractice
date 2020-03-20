(include "10-value-of-all-this.ss")
(println (new-entry '(appetizer entree bevarage) '(pate boeuf vin)));((appetizer entree bevarage) (pate boeuf vin))
(println (new-entry '(appetizer entree bevarage) '(beer beer beer)));((appetizer entree bevarage) (beer beer beer))
(println (new-entry '(bevarage dessert) '((food is) (number one with us))));((bevarage dessert) ((food is) (number one with us)))

(println(lookup-in-entry
  'entree
  '((appetizer entree bevarage) (pate boeuf vin))
  (lambda (n) '())));boeuf
(println(lookup-in-entry
  'no-such-item
  '((appetizer entree bevarage) (pate boeuf vin))
  (lambda (n) '())));()
(println(lookup-in-table
  'beverage
  '(((entree dessert) (spaghetti spumoni))
    ((appetizer entree beverage) (food tastes good)))
  (lambda (n) '())))
(println((lambda (nothing)
   (cons nothing '()))
 '(from nothing comes something))); ((from nothing comes something)) 
(println((lambda (nothing)
   (cond
     (nothing (quote something))
     (else (quote nothing))))
 #t));something

