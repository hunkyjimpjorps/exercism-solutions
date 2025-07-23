#lang racket

(provide translate)

(define (translate text)
  (string-join (map translate-word (string-split text))))

(define (translate-word word)
  (match word
    [(regexp #rx"^[xy][^aeiou]") (string-append word "ay")]
    [(regexp #rx"^[aeiou]") (string-append word "ay")]
    [(regexp #rx"^([^aeiou]*qu)(.*)" (list _ h t)) (string-append t h "ay")]
    [(regexp #rx"^([^aeiou][^aeiouy]*)(.*)" (list _ h t)) (string-append t h "ay")]))
