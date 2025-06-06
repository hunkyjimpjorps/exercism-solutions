#lang racket

(provide score)

(define letter-scores
  '((1  (A E I O U L N R S T))
    (2  (D G))
    (3  (B C M P))
    (4  (F H V W Y))
    (5  (K))
    (8  (J X))
    (10 (Q Z))))

(define score-hash (make-hash))
(for ([score letter-scores])
  (for ([letter (cadr score)])
    (hash-set! score-hash letter (car score))))

(define (letter->symbol a)
  (string->symbol (string-upcase (string a))))

(define (score word)
  (for/sum ([letter (in-string word)])
    (hash-ref score-hash (letter->symbol letter))))