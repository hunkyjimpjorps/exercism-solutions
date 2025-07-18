#lang racket

(provide plants)

(define roster
  (list "Alice"
        "Bob"
        "Charlie"
        "David"
        "Eve"
        "Fred"
        "Ginny"
        "Harriet"
        "Ileana"
        "Joseph"
        "Kincaid"
        "Larry"))

(define (char->plant chr)
  (match chr
    [#\G "grass"]
    [#\C "clover"]
    [#\R "radishes"]
    [#\V "violets"]))

(define (plants diagram student)
  (match-define (list upper-garden lower-garden) (string-split diagram "\n"))
  (for/first ([plot-owner (in-list roster)]
              [upper-half (in-slice 2 upper-garden)]
              [lower-half (in-slice 2 lower-garden)]
              #:when (equal? student plot-owner)
              #:do [(define plot (append upper-half lower-half))])
    (map char->plant plot)))
