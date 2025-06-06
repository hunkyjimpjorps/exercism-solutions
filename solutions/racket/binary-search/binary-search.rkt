#lang racket

(provide binary-search)

(define (binary-search vec value)
  (define (do-binary-search left index right)
    (define found (vector-ref vec index))
    (cond
      [(= found value) index]
      [(>= left right) #f]
      [(< found value)
       (define left (add1 index))
       (do-binary-search left (+ left (quotient (- right left) 2)) right)]
      [(> found value)
       (define right (sub1 index))
       (do-binary-search left (+ left (quotient (- right left) 2)) right)]))

  (match vec
    [(vector) #f]
    [_
     (define l (vector-length vec))
     (do-binary-search 0 (quotient l 2) (sub1 l))]))
