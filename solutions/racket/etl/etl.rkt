#lang racket

(provide etl)

(define (etl old-hash)
  (define new-hash (make-hash))
  (for ([(score letters) (in-hash old-hash)])
    (if (nonpositive-integer? score)
        (raise-arguments-error 'negative-score
                               "Scores must be positive"
                               "score" score
                               "letters" letters)
        (for ([letter (in-list letters)])
          (if (not (string? letter))
              (raise-arguments-error 'wrong-letter-format
                                     "Letters must be strings"
                                     "score" score
                                     "letter" letter)
              (hash-set! new-hash (string-downcase letter) score)))))
  new-hash) 