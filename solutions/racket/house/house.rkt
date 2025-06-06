#lang racket

(provide house)

(define beginning "This is")
(define ending " the house that Jack built.")

(struct actor (noun verb))
(define actors
  (list (actor "malt" "lay in")
        (actor "rat" "ate")
        (actor "cat" "killed")
        (actor "dog" "worried")
        (actor "cow with the crumpled horn" "tossed")
        (actor "maiden all forlorn" "milked")
        (actor "man all tattered and torn" "kissed")
        (actor "priest all shaven and shorn" "married")
        (actor "rooster that crowed in the morn" "woke")
        (actor "farmer sowing his corn" "kept")
        (actor "horse and the hound and the horn" "belonged to")))

(define (house-verse n)
  (for/lists
   (lines #:result (string-join (reverse lines) "" #:before-first beginning #:after-last ending))
   ([i (in-range 1 n)] [a (in-list actors)])
   (match-define (actor noun verb) a)
   (~a " the " noun "\nthat " verb)))

(define (house [start 1] [end 12])
  (string-join (map house-verse (inclusive-range start end)) "\n\n"))
