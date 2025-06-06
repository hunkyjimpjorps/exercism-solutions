#lang racket
(require threading)
(provide isogram?)

(define (isogram? s)
  (define process-s
    (~> s
      (string-replace #px"-|\\s" "")
      string-downcase
      string->list
      (sort char>?)))
  (equal? process-s (remove-duplicates process-s)))