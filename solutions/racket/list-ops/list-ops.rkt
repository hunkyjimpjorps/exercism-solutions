#lang racket

(provide my-length
         my-reverse
         my-map
         my-filter
         my-fold
         my-append
         my-concatenate)

(define (my-length lst [acc 0])
  (if (empty? lst)
      acc
      (my-length (cdr lst) (add1 acc))))

(define (my-reverse lst [acc '()])
  (if (empty? lst)
      acc
      (my-reverse (cdr lst) (cons (car lst) acc))))

(define (my-map proc lst)
  (if (empty? lst)
      '()
      (cons (proc (car lst))
            (my-map proc (cdr lst)))))

(define (my-filter pred lst)
  (if (empty? lst)
      '()
      (if (pred (car lst))
          (cons (car lst)
                (my-filter pred (cdr lst)))
          (my-filter pred (cdr lst)))))

(define (my-fold proc acc lst)
  (if (empty? lst)
      acc
      (my-fold proc (proc (car lst) acc) (cdr lst))))

(define (my-append lst app)
  (cond [(empty? lst) app]
        [(empty? (cdr lst)) (cons (car lst)
                                  app)]
        [else (cons (car lst)
                    (my-append (cdr lst) app))]))

(define (my-concatenate lst)
  (cond [(empty? lst) '()]
        [(list? (car lst)) (my-append (my-concatenate (car lst))
                                      (my-concatenate (cdr lst)))]
        [else (cons (car lst)
                    (my-concatenate (cdr lst)))]))