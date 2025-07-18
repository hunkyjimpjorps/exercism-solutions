#lang racket
(require math/number-theory)

(provide rows)

(define (rows height)
  (for/list ([n (in-range 0 height)])
    (for/list ([k (in-inclusive-range 0 n)])
      (binomial n k))))
