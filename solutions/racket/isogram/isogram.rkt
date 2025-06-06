#lang racket
(require threading)
(provide isogram?)

(define (isogram? s)
  (define process-s
    (~> s
      (string-replace _ #px"-|\\s" "")
      string-downcase
      string->list
      (sort _ char>?)))
  (equal? process-s (remove-duplicates process-s)))