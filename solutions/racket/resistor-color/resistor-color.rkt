#lang racket

(provide color-code
         colors)

(define color-list
  (list "black" "brown" "red" "orange" "yellow" "green" "blue" "violet" "grey" "white"))

(define color-hash
  (for/hash ([c (in-list color-list)] [n 10])
    (values c n)))

(define (color-code color)
  (hash-ref color-hash color))

(define (colors)
  color-list)
