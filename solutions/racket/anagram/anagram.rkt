#lang racket

(provide anagrams-for)
(require (only-in threading ~>))

(define (anagrams-for word word-list)
  (define (sort-chars w)
    (~> w
      string-downcase
      string->list
      (sort char<?)
      list->string))
  (define sort-chars-word (sort-chars word))
  (for/list ([candidate (in-list word-list)]
             #:when (and (equal? sort-chars-word (sort-chars candidate))
                         (not (equal? word candidate))))
    candidate))