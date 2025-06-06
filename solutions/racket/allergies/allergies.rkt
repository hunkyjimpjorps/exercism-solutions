#lang racket

(provide list-allergies allergic-to?)

(define *allergens* '("eggs"
                      "peanuts"
                      "shellfish"
                      "strawberries"
                      "tomatoes"
                      "chocolate"
                      "pollen"
                      "cats"))

(define *allergens-num* (length *allergens*))

(define (score->bit-string score)
  (map (λ (bit) (if (char=? bit #\1) #true #false))
       (take (reverse (string->list (~r score
                                        #:base 2
                                        #:min-width *allergens-num*
                                        #:pad-string "0")))
             *allergens-num*)))

(define (list-allergies score)
  (for/list ([allergen (in-list *allergens*)]
             [bit (in-list (score->bit-string score))]
             #:when bit)
    allergen))

(define (allergic-to? allergen score)
  (define allergen-index (index-of *allergens* allergen))
  (list-ref (score->bit-string score) allergen-index))
