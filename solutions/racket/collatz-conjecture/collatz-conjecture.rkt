#lang racket

(provide collatz)

(define/contract (collatz n [acc 0])
  (-> exact-positive-integer? natural?)
  (cond [(= n 1) acc]
        [(odd? n) (collatz (+ (* 3 n) 1) (add1 acc))]
        [(even? n) (collatz (/ n 2) (add1 acc))]))

