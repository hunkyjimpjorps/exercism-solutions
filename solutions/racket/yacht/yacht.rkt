#lang racket

(provide yacht)

(define (yacht dice category)
  (define bag (hand->bag dice))
  (match category
    ["ones" (score-multiples bag 1)]
    ["twos" (score-multiples bag 2)]
    ["threes" (score-multiples bag 3)]
    ["fours" (score-multiples bag 4)]
    ["fives" (score-multiples bag 5)]
    ["sixes" (score-multiples bag 6)]
    ["full house" (score-full-house bag)]
    ["four of a kind" (score-four-of-a-kind bag)]
    ["little straight" (score-little-straight bag)]
    ["big straight" (score-big-straight bag)]
    ["yacht" (score-yacht bag)]
    ["choice" (score-choice bag)]))

(define (hand->bag hand)
  (for/fold ([bag (hash)]) ([die hand])
    (dict-update bag die add1 0)))

(define (score-multiples bag val)
  (for/sum ([(die n) (in-hash bag)] #:when (= die val)) (* die n)))

(define (score-full-house bag)
  (match (hash-values bag)
    [(list-no-order 2 3) (score-choice bag)]
    [_ 0]))

(define (score-four-of-a-kind bag)
  (match (hash->list bag)
    [(list (cons n 5)) (* n 4)]
    [(list-no-order (cons n 4) (cons _ 1)) (* n 4)]
    [_ 0]))

(define (score-little-straight bag)
  (match (hash-keys bag)
    [(list-no-order 1 2 3 4 5) 30]
    [_ 0]))

(define (score-big-straight bag)
  (match (hash-keys bag)
    [(list-no-order 2 3 4 5 6) 30]
    [_ 0]))

(define (score-yacht bag)
  (match (hash->list bag)
    [(list (cons _ 5)) 50]
    [_ 0]))

(define (score-choice bag)
  (for/sum ([(die n) (in-hash bag)]) (* die n)))
