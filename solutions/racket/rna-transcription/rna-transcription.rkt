#lang racket

(provide to-rna)

(define *rna-complements*
  (make-hash '((#\C . #\G)
               (#\G . #\C)
               (#\T . #\A)
               (#\A . #\U))))

(define (to-rna strand)
  (list->string (for/list ([base (in-string strand)])
                  (hash-ref *rna-complements* base))))