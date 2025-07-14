#lang racket

(provide primes)

(define (primes limit)
  (cond
    [(< limit 2) '()]
    [(= limit 2) '(2)]
    [else (sieve-out (inclusive-range 3 limit 2) limit '(2))]))

(define (sieve-out lst limit acc)
  (match-define (list* h t) lst)
  (cond
    [(< limit (* h h)) (append (reverse acc) lst)]
    [else (sieve-out (filter-not (λ (n) (zero? (remainder n h))) t) limit (cons h acc))]))
