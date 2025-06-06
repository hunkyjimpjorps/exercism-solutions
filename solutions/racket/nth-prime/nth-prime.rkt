#lang racket

(provide nth-prime)

(define (nth-prime number)
  (stream-ref prime-stream (sub1 number)))

(define (prime? n)
  (cond
    [(= n 2) #true]
    [(even? n) #false]
    [else
     (for/and ([div (in-inclusive-range 3 (integer-sqrt n) 2)])
       (not (zero? (modulo n div))))]))

(define prime-stream (for/stream ([n (in-naturals 2)] #:when (prime? n)) n))
