#lang racket

(provide sublist?)

(define (sublist? s l)
  (cond
    [(equal? s l) 'equal]
    [(and ((length s) . < . (length l)) (contains? s l)) 'sublist]
    [(contains? l s) 'superlist]
    [else 'unequal]))

(define (contains? sub sup)
  (cond
    [((length sub) . > . (length sup)) #false]
    [(list-prefix? sub sup) #true]
    [else (contains? sub (rest sup))]))
