#lang racket

(provide recite)

(define (recite lst)
  (cond
    [(empty? lst) '()]
    [else
     (append (for/list ([cause (in-list lst)]
                        [effect (in-list (rest lst))])
               (~a "For want of a " cause " the " effect " was lost."))
             (list (~a "And all for the want of a " (first lst) ".")))]))
