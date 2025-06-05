#lang racket

(provide largest-product)

(define (largest-product digits span)
  (apply max (for/list ([window (windows (to-digits digits) span)]) (apply * window))))

(define (windows lst size)
  (cond
    [(= (length lst) size) (list lst)]
    [else (cons (take lst size)
                (windows (rest lst) size))]))

(define (to-digits str)
  (for/list ([ch (in-string str)]
             #:do [(unless (char-numeric? ch) (error "invalid character"))])
    (string->number (string ch))))