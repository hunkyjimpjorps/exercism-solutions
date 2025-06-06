#lang racket

(provide word-count)
(require threading)

(define (word-count sentence)
  (define word-list
    (~> sentence
        string-downcase
        string-normalize-spaces
        (string-replace _ #px",|[^[:alnum:]]+\\s|\\s[^[:alnum:]]+|[^[:alnum:]]+$" " ")
        string-split))
  (define word-hash (make-hash))
  (for ([word (in-list word-list)])
    (hash-update! word-hash word add1 0))
  word-hash)