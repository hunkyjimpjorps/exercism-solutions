#lang racket

(provide triplets-with-sum)

(define (triplets-with-sum p)
  (for*/list ([a (in-inclusive-range 1 (quotient p 3))]
              [b (in-inclusive-range a (quotient p 2))]
              #:do [(define c (- p a b))]
              #:when (= (+ (sqr a) (sqr b)) (sqr c)))
    (list a b c)))
