#lang racket
(provide encode
         decode)
(require threading)

(define (char->index c)
  (cond [(char-lower-case? c) (- (char->integer c) 97)]
        [(char-upper-case? c) (- (char->integer c) 65)]))

(define (index->char i) (integer->char (+ i 97)))

(define/contract (encode msg)
  (-> string? string?)
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
             (- 25 _)
             index->char)))))
  (~> encoded-msg-raw
    (regexp-match* #px".{5}|.{1,}" _)
    string-join))

(define/contract (decode msg)
  (-> string? string?)
  (list->string
   (for/list ([c (in-string msg)]
              #:unless (char-whitespace? c))
     (if (char-numeric? c)
         c
         (~> c
           char->index
           (- 25 _)
           index->char)))))
