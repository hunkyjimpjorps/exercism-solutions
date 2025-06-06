#lang racket
(require racket/date)
(provide meetup-day)

(define (make-date year month day)
  (seconds->date (find-seconds 0 0 0 day month year #f) #f))

(define *days* '(Sunday Monday Tuesday Wednesday Thursday Friday Saturday))
(define (day-number day-symbol) (index-of *days* day-symbol))

(define (get-range week-symbol)
  (case week-symbol
    ['first  (inclusive-range 1  7)]
    ['second (inclusive-range 8  14)]
    ['third  (inclusive-range 15 21)]
    ['fourth (inclusive-range 22 28)]
    ['last   (inclusive-range 29 31)]
    ['teenth (inclusive-range 13 19)]))

(define (meetup-day year month weekday descriptor)
  (define which-day (day-number weekday))
  (for/first ([d (in-list (get-range descriptor))]
              #:when (= (day-number weekday)
                        (date-week-day (make-date year month d))))
    (make-date year month d)))