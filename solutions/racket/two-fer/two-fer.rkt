#lang racket

(provide two-fer)

(define/contract (two-fer [name "you"])
  (->* () (string?) string?)
  (format "One for ~a, one for me." name))