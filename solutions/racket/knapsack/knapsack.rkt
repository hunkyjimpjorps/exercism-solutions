#lang racket

(provide item
         maximum-value)

(struct item (weight value) #:transparent)
(struct knapsack (value remaining) #:transparent)

(define (maximum-value maximum-weight items)
  (knapsack-value (pack-knapsack items (knapsack 0 maximum-weight))))

(define (pack-knapsack items sack)
  (cond
    [(empty? items) sack]
    [(> (item-weight (first items)) (knapsack-remaining sack)) (pack-knapsack (rest items) sack)]
    [else
     (define take-it
       (pack-knapsack (rest items)
                      (knapsack (+ (knapsack-value sack) (item-value (first items)))
                                (- (knapsack-remaining sack) (item-weight (first items))))))
     (define leave-it (pack-knapsack (rest items) sack))
     (if (> (knapsack-value take-it) (knapsack-value leave-it)) take-it leave-it)]))
