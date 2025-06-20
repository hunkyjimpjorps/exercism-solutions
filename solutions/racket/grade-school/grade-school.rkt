#lang racket

(provide school%)

(define school%
  (class object%
    (define current-roster (make-hash))
    (super-new)

    (define/public (roster)
      (for/list ([(grade student) (in-hash (hash-flip current-roster))])
        (cons grade (sort student string<?))))

    (define/public (grade year) (sort (hash-ref (hash-flip current-roster) year '()) string<?))

    (define/public (add student grade)
      (cond
        [(hash-has-key? current-roster student) #f]
        [else
         (hash-set! current-roster student grade)
         #t]))))

(define (hash-flip ht)
  (for/fold ([acc (hash)]) ([(k v) (in-hash ht)])
    (hash-update acc v (curry cons k) '())))
