#lang racket

(provide proteins)

(define (proteins strand)
  (for/list ([raw-codon (in-slice 3 strand)]
             #:do [(define codon (apply string raw-codon))]
             #:break (member codon '("UAA" "UAG" "UGA")))
    (case codon
      [("AUG") "Methionine"]
      [("UUU" "UUC") "Phenylalanine"]
      [("UUA" "UUG") "Leucine"]
      [("UCU" "UCC" "UCA" "UCG") "Serine"]
      [("UAU" "UAC") "Tyrosine"]
      [("UGU" "UGC") "Cysteine"]
      [("UGG") "Tryptophan"]
      [else (error 'invalid-codon)])))
