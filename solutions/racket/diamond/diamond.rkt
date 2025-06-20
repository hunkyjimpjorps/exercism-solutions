#lang racket

(provide rows)

(define ALPHABET "ABCDEFGHIJKLMNOPQRSTUVWXYZ")

(define (rows high-char)
  (define width (add1 (* 2 (char-diff high-char #\A))))
  (define chars
    (for/lists (half #:result (append half (list high-char) (reverse half)))
               ([ch (in-string ALPHABET)] #:break (equal? high-char ch))
               ch))
  (for/list ([char (in-list chars)])
    (to-row char width)))

(define (to-row char width)
  (case char
    [(#\A) (~a #\A #:min-width width #:align 'center)]
    [else (~a char char #:min-width width #:align 'center #:separator (inner-spaces char))]))

(define (char-diff char1 char2)
  (- (char->integer char1) (char->integer char2)))

(define (inner-spaces char)
  (make-string (max 0 (sub1 (* 2 (char-diff char #\A)))) #\space))
