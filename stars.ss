(include "common.ss")
;rember*
(define rember*
  (lambda (a lat)
    (cond
      ((null? lat) '())
      ((atom? (car lat)) 
        (cond
            ((eq? a (car lat)) (rember* a (cdr lat)))
            (else (cons (car lat)(rember* a (cdr lat))))
            ))
      (else (cons(rember* a (car lat))(rember* a (cdr lat))))
      )))