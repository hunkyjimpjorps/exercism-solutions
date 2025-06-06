#lang racket

(provide score)

(define (score x y)
  (define radius (sqrt (+ (sqr x) (sqr y))))
  (cond
    [(<= radius 1) 10]
    [(<= radius 5) 5]
    [(<= radius 10) 1]
    [else 0]))
