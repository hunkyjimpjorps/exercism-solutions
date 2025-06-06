#lang racket

(provide clock
         add
         subtract
         clock->string)

(struct Clock (hour minute) #:transparent)

(define (clock h m)
  (Clock (rem (rem (+ h (div m 60)) 24) 24) (rem m 60)))

(define (clock->string c)
  (~a (~r (Clock-hour c) #:min-width 2 #:pad-string "0")
      (~r (Clock-minute c) #:min-width 2 #:pad-string "0")
      #:separator ":"))

(define (add c minutes)
  (clock (Clock-hour c) (+ (Clock-minute c) minutes)))

(define (subtract c minutes)
  (clock (Clock-hour c) (- (Clock-minute c) minutes)))

(define (div a b)
  (* (sgn b) (floor (/ a (abs b)))))

(define (rem a b)
  (- a (* (abs b) (floor (/ a (abs b))))))
