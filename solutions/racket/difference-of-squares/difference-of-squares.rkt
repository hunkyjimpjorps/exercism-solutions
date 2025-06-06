#lang racket

(provide sum-of-squares square-of-sum difference)

(define/contract (sum-of-squares n)
  (-> natural? natural?)
  (apply + (map sqr (inclusive-range 1 n))))

(define/contract (square-of-sum n)
  (-> natural? natural?)
  (sqr (apply + (inclusive-range 1 n))))

(define/contract (difference n)
  (-> natural? integer?)
  (- (square-of-sum n) (sum-of-squares n) ))