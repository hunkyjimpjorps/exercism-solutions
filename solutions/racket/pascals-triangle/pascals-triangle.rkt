#lang racket
(provide rows)

(define (factorial n)
  (for/product ([i n]) (add1 i)))

(define (combinations n k)
  (/ (factorial n) (factorial k) (factorial (- n k))))

(define (rows height)
  (for/list ([n (in-range 0 height)])
    (for/list ([k (in-inclusive-range 0 n)])
      (combinations n k))))
