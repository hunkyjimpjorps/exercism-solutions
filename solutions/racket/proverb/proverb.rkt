#lang racket

(provide recite)

(define (recite lst)
  (append (for/list (#:break (empty? lst)
                     [cause (in-list lst)]
                     [effect (in-list (rest lst))])
            (~a "For want of a " cause " the " effect " was lost."))
          (if (empty? lst)
              '()
              (list (~a "And all for the want of a " (first lst) ".")))))
