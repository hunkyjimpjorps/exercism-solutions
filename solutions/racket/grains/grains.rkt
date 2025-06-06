#lang racket

(provide square total)

(define (square s)
  (expt 2 (sub1 s)))

(define (total)
  (for/sum ([s (in-range 1 65)])
    (square s)))