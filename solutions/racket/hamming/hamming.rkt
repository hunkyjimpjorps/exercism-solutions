#lang racket

(provide hamming-distance)

(define (hamming-distance old-strand new-strand)
  (unless (= (string-length old-strand)
             (string-length new-strand))
    (raise-arguments-error 'length-mismatch
                           "Hamming distance undefined for strands of different length"
                           "old strand" (string-length old-strand)
                           "new strand" (string-length new-strand)))
  (for/sum ([old-base (in-string old-strand)]
            [new-base (in-string new-strand)]
            #:unless (equal? old-base new-base)) 1))