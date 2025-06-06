#lang racket
(provide encode
         decode)

(define substitution
  (for/hash ([from (in-string (build-string 26 (λ (i) (integer->char (+ i 97)))))]
             [to (in-string (build-string 26 (λ (i) (integer->char (- 122 i)))))])
    (values from to)))

(define (encode msg)
  (define sanitized-msg (string-replace (string-downcase msg) #rx"[^a-z0-9]" ""))
  (string-join (regexp-match* #px".{1,5}"
                              (list->string (for/list ([from (in-string sanitized-msg)])
                                              (hash-ref substitution from from))))))

(define (decode msg)
  (list->string (for/list ([from (in-string (string-replace msg " " ""))])
                  (hash-ref substitution from from))))
