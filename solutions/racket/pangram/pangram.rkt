#lang racket

(provide pangram?)

(define (pangram? sentence)
  (let* ([chars (string-downcase sentence)]
         [chars (string->list chars)]
         [chars (filter char-alphabetic? chars)]
         [chars (list->set chars)])
    (= 26 (set-count chars))))
