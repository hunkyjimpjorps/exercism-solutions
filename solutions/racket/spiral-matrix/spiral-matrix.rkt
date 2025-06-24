#lang racket

(provide spiral-matrix)

(define (spiral-matrix n)
  (cond
    [(zero? n) '()]
    [else (make-spiral-matrix 1 n n)]))

(define (make-spiral-matrix start row col)
  (cond
    [(zero? col) '(())]
    [else (cons (make-line start col) (spin-rest start col row))]))

(define (make-line start col)
  (range start (+ start col)))

(define (spin-rest start col row)
  (rotate (make-spiral-matrix (+ start col) col (sub1 row))))

(define (rotate m)
  (apply map list (reverse m)))
