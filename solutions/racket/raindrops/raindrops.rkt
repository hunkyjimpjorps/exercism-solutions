#lang racket

(provide convert)

(define droplet-divisors '((3 "Pling")
                           (5 "Plang")
                           (7 "Plong")))

(define (convert n)
  (let ([droplets 
         (for/list ([d (in-list droplet-divisors)]
                    #:when (= 0 (modulo n (first d))))
           (second d))])
    (if (empty? droplets)
        (~a n)
        (apply string-append droplets))))