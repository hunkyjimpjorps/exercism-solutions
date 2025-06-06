#lang racket

(provide armstrong-number?)

(define (armstrong-number? n)
  (define (get-digits n)
    (for/fold ([digits '()]
               [remaining n]
               #:result digits)
              ([_ (in-naturals)]
               #:break (= remaining 0))
      (values (append (list (remainder remaining 10)) digits)
              (quotient remaining 10))))
  (define digits (get-digits n))
  (define digit-length (length digits))
  (= n (apply + (map (λ (n) (expt n digit-length)) digits))))
