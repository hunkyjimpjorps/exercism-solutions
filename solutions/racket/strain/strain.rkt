#lang racket

(provide keep
         discard)

(define (keep lst predicate)
  (match lst
    ['() '()]
    [(list* (? predicate h) t) (cons h (keep t predicate))]
    [(list* _ t) (keep t predicate)]))

(define (discard lst predicate)
  (keep lst (negate predicate)))
