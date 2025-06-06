#lang racket

(provide number->eggs)

(define (number->eggs n)
  (let* ([in-binary (~r n #:base 2)] [ones-only (string-replace in-binary "0" "")])
    (string-length ones-only)))
