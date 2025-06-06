#lang racket

(provide convert)

(define (convert n)
  (string-append
   (if (= 0 (remainder n 3)) "Pling" "")
   (if (= 0 (remainder n 5)) "Plang" "")
   (if (= 0 (remainder n 7)) "Plong" "")
   (if (andmap (λ (div) (< 0 (remainder n div))) '(3 5 7)) (~a n) "")))