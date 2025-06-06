#lang racket/base
(require racket/contract
         racket/string
         math/number-theory
         threading)

(provide (contract-out
          [encode (string?
                   exact-nonnegative-integer?
                   exact-nonnegative-integer? . -> . string?)]
          [decode (string?
                   exact-nonnegative-integer?
                   exact-nonnegative-integer? . -> . string?)]))

(define *m* 26)

(define (char->index c)
  (cond [(char-lower-case? c) (- (char->integer c) 97)]
        [(char-upper-case? c) (- (char->integer c) 65)]))

(define (index->char i)
  (integer->char (+ i 97)))

(define (encode msg a b)
  (unless (coprime? a *m*)
    (raise-arguments-error 'not-coprime
                           "a and m are not coprime"
                           "a" a
                           "m" *m*))
  (define msg-clean
    (~> msg
      (string-replace #px"[^[:alnum:]]" "")
      string-downcase))
  (define encoded-msg-raw
    (list->string
     (for/list ([c (in-string msg-clean)])
       (if (char-numeric? c)
           c
           (~> c
             char->index
             (* a)
             (+ b)
             (modulo *m*)
             index->char)))))
  (~> encoded-msg-raw
    (regexp-match* #px".{5}|.{1,}" _)
    string-join))

(define (decode msg a b)
  (unless (coprime? a *m*)
    (raise-arguments-error 'not-coprime
                           "a and m are not coprime"
                           "a" a
                           "m" *m*))
  (define a^-1 (modular-inverse a *m*))
  (list->string
   (for/list ([c (in-string msg)]
              #:unless (char-whitespace? c))
     (if (char-numeric? c)
         c
         (~> c
           char->index
           (- b)
           (* a^-1)
           (modulo *m*)
           index->char)))))