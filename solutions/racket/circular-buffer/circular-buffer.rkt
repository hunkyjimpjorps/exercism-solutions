#lang racket

(provide circular-buffer%)

(define circular-buffer%
  (class object%
    (super-new)
    (init capacity)
    (define max-size capacity)
    (define current-size 0)
    (define contents '())

    (define/public (clear)
      (set! current-size 0)
      (set! contents '()))

    (define/public (read)
      (cond
        [(empty? contents) (error 'empty-buffer)]
        [else
         (match-define (list remaining ... oldest) contents)
         (set! current-size (sub1 current-size))
         (set! contents remaining)
         oldest]))

    (define/public (write val)
      (cond
        [(= current-size max-size) (error 'full-buffer)]
        [else
         (set! current-size (add1 current-size))
         (set! contents (cons val contents))]))

    (define/public (overwrite val)
      (cond
        [(= current-size max-size) (set! contents (cons val (drop-right contents 1)))]
        [else
         (set! current-size (add1 current-size))
         (set! contents (cons val contents))]))))
