#lang racket

(provide circular-buffer%)

(define circular-buffer%
  (class object%
    (super-new)
    (init capacity)
    (define max-size capacity)
    (define contents '())

    (define/public (clear) (set! contents '()))

    (define/public (read)
      (cond
        [(empty? contents) (error 'empty-buffer)]
        [else
         (match-define (list remaining ... oldest) contents)
         (set! contents remaining)
         oldest]))

    (define/public (write val)
      (cond
        [(= (length contents) max-size) (error 'full-buffer)]
        [else (set! contents (cons val contents))]))

    (define/public (overwrite val)
      (cond
        [(= (length contents) max-size) (set! contents (cons val (drop-right contents 1)))]
        [else (set! contents (cons val contents))]))))
