#lang racket

(provide color-code)

(define color-list
  (list "black" "brown" "red" "orange" "yellow" "green" "blue" "violet" "grey" "white"))

(define color-hash
  (for/hash ([c (in-list color-list)] [n 10])
    (values c n)))

(define (color-val c)
  (hash-ref color-hash c))

(define (color-code color)
  (match color
    [(list c1 c2 _ ...) (+ (* 10 (color-val c1)) (color-val c2))]))
