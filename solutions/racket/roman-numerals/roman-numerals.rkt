#lang racket

(provide to-roman)

(define *to-roman* '((1000 . "M" )
                     ( 900 . "CM")
                     ( 500 . "D" )
                     ( 400 . "CD")
                     ( 100 . "C" )
                     (  90 . "XC")
                     (  50 . "L" )
                     (  40 . "XL")
                     (  10 . "X" )
                     (   9 . "IX")
                     (   5 . "V" )
                     (   4 . "IV")
                     (   1 . "I" )))

(define (to-roman n [conversions *to-roman*] [acc '()])
  (cond [(empty? conversions)
         ; if the conversion list is empty, concatenate and return all the accumulated digits
         (apply string-append acc)]
        [(n . >= . (caar conversions))
         ; if the top digit is less than the current amount,
         ; subtract that digit's value from the current amount
         ; and add that digit to the accumulator
         (to-roman (- n (caar conversions))
                   conversions
                   (append acc (list (cdar conversions))))]
        [else
         ; otherwise, drop the top digit and continue 
         (to-roman n
                   (cdr conversions)
                   acc)]))