#lang racket

(provide square-root)

(define (square-root radicand)
  (do-square-root 1 radicand radicand))

(define (do-square-root from to radicand)
  (define guess (quotient (+ from to) 2))
  (cond
    [(= (* guess guess) radicand) guess]
    [(> (* guess guess) radicand) (do-square-root from guess radicand)]
    [else (do-square-root guess to radicand)]))
