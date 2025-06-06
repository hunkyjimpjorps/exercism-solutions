#lang racket

(require racket/hash)

(provide calculate-frequencies)

(define (calculate-frequencies texts)
  (make-hash
   (hash->list
    (apply hash-union
           #:combine +
           (hash)
           (for/list ([text (in-list texts)])
             (touch (future (λ () (frequencies text)))))))))

(define (frequencies str)
  (for/fold ([freqs (hash)])
            ([ch (in-string str)]
             #:when (char-alphabetic? ch))
    (hash-update freqs (char-downcase ch) add1 0)))