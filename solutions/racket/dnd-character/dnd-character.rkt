#lang racket

(provide (struct-out character)
         ability
         make-character
         modifier)

(struct character (strength dexterity constitution intelligence wisdom charisma hitpoints))

(define (ability)
  (for/sum [(_ 3)] (random 1 7)))

(define (modifier value)
  (floor (/ (- value 10) 2)))

(define (make-character)
  (define con (ability))
  (character (ability) (ability) con (ability) (ability) (ability) (+ 10 (modifier con))))
