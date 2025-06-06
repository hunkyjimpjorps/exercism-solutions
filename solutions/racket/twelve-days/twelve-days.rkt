#lang racket

(provide twelve-days)

(define ordinals
  (list "first"
        "second"
        "third"
        "fourth"
        "fifth"
        "sixth"
        "seventh"
        "eighth"
        "ninth"
        "tenth"
        "eleventh"
        "twelfth"))

(define preludes
  (for/hash ([ord (in-list ordinals)] [i (in-naturals 1)])
    (values i (~a "On the " ord " day of Christmas my true love gave to me: "))))

(define gifts-list
  (list "a Partridge in a Pear Tree"
        "two Turtle Doves"
        "three French Hens"
        "four Calling Birds"
        "five Gold Rings"
        "six Geese-a-Laying"
        "seven Swans-a-Swimming"
        "eight Maids-a-Milking"
        "nine Ladies Dancing"
        "ten Lords-a-Leaping"
        "eleven Pipers Piping"
        "twelve Drummers Drumming"))

(define daily-gifts
  (for/hash ([gift (in-list gifts-list)] [i (in-naturals 1)])
    (values i gift)))

(define (twelve-days-verse n)
  (define gifts
    (for/list ([i (in-range n 0 -1)])
      (hash-ref daily-gifts i)))
  (string-join gifts
               ", "
               #:before-first (hash-ref preludes n)
               #:before-last ", and "
               #:after-last "."))

(define (twelve-days [start 1] [end 12])
  (define verses
    (for/list ([n (inclusive-range start end)])
      (twelve-days-verse n)))
  (string-join verses "\n\n"))
