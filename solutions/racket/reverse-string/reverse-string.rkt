#lang racket
(provide my-reverse)

(define (my-reverse s)
  (apply string (reverse (string->list s))))