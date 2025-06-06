#lang racket

(provide valid?)

(define (valid? digits)
  (match (string-replace digits " " "")
    [(or (regexp #rx"[^0-9]") (app string-length (or 0 1))) #false]
    [parsed (zero? (modulo (calculate-checksum parsed) 10))]))

(define (calculate-checksum str)
  (for/sum ([(chr i) (in-indexed (reverse (string->list str)))]
            #:do [(define n (* (add1 (modulo i 2)) (string->number (string chr))))])
    (if (n . > . 9) (- n 9) n)))
