#lang racket

(provide add-gigasecond)

(require racket/date
         threading)

(define (add-gigasecond start-time)
  (~> start-time
    date->seconds
    (+ (expt 10 9))
    seconds->date))
