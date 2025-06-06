#lang racket

(provide sublist?)

(define (sublist? left right)
  (cond
    [(equal? left right) 'equal]
    [(contains? left right) 'sublist]
    [(contains? right left) 'superlist]
    [else 'unequal]))

(define/match (contains? sub sup)
  [('() _) #true]
  [((app length sub-length) (app length sup-length))
   #:when (sub-length . > . sup-length)
   #false]
  [(_ _)
   (match (member (first sub) sup)
     [#false #false]
     [(? (curry list-prefix? sub)) #true]
     [(list* _ xs) (contains? sub xs)])])
