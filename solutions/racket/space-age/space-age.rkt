#lang racket

(provide on-mercury
         on-venus
         on-earth
         on-mars
         on-jupiter
         on-saturn
         on-uranus
         on-neptune)

(define earth-year 31557600)

(define ((on-planet scale-factor) seconds)
  (/ seconds earth-year scale-factor))

(define on-mercury (on-planet 0.2408467))
(define on-venus (on-planet 0.61519726))
(define on-earth (on-planet 1.0))
(define on-mars (on-planet 1.8808158))
(define on-jupiter (on-planet 11.862615))
(define on-saturn (on-planet 29.447498))
(define on-uranus (on-planet 84.016846))
(define on-neptune (on-planet 164.79132))
