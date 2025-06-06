#lang racket

(provide encode
         decode)

(define (encode text)
  (apply ~a
         (for/list ([pair (do-encode (string->list text))])
           (match pair
             [(cons ch 1) (~a ch)]
             [(cons ch n) (~a n ch)]))))

(define/match (do-encode _chrs [_acc '()])
  [('() acc) (reverse acc)]
  [((list* h t) (list* (cons h n) acc-rest)) (do-encode t (cons (cons h (add1 n)) acc-rest))]
  [((list* h t) acc) (do-encode t (cons (cons h 1) acc))])

(define (decode code)
  (apply ~a
         (for/list ([pair (regexp-match* #px"(\\d*)([\\w\\s])" code #:match-select cdr)])
           (match pair
             [(list "" ch) ch]
             [(list (app string->number n) ch) (apply ~a (make-list n ch))]))))
