#lang racket

(provide nucleotide-counts)

(define (nucleotide-counts strand)
  (define nucleotides-hash (make-hash '((#\A . 0)
                                        (#\C . 0)
                                        (#\G . 0)
                                        (#\T . 0))))
  (for ([nucleotide [in-string strand]])
    (hash-update! nucleotides-hash nucleotide add1))
  (sort (hash->list nucleotides-hash) char<? #:key car))