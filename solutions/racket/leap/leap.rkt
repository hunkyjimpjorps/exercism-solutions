#lang racket

(provide leap-year?)

(define/contract (leap-year? year)
  (-> natural? boolean?)
  (cond [(= 0 (remainder year 400)) #true]
        [(= 0 (remainder year 100)) #false]
        [(= 0 (remainder year 4)) #true]
        [else #false]))