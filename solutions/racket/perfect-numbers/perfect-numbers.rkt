#lang racket

(provide classify)
(require (only-in math/number-theory divisors))

(define/contract (classify num)
  (-> natural? symbol?)
  (define factor-sum
    (apply + (cdr (reverse (divisors num)))))
  (cond [(factor-sum . = . num) 'perfect]
        [(factor-sum . < . num) 'deficient]
        [else 'abundant]))


