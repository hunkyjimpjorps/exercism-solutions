#lang racket

(provide rotate)

(define alphabet (build-list 26 (λ (i) (integer->char (+ (char->integer #\a) i)))))

(define (transform-char ch h)
  (cond
    [(char-lower-case? ch) (hash-ref h ch)]
    [(char-upper-case? ch) (char-upcase (hash-ref h (char-downcase ch)))]
    [else ch]))

(define (rotate text key)
  (define rotate-hash
    (for/hash ([c (in-list alphabet)] [c* (sequence-tail (in-cycle alphabet) key)])
      (values c c*)))
  (list->string (for/list ([c (in-string text)])
                  (transform-char c rotate-hash))))
