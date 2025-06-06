#lang racket/base
(require (only-in racket/string string-join)
         (only-in racket/math natural?)
         (only-in racket/list flatten)
         (only-in racket/function curry)
         racket/contract)

;; Converts integers to English-language descriptions

;; --- NOTE -------------------------------------------------------------------
;; The test cases in "say-test.rkt" assume:
;; - Calling a function with an out-of-range argument triggers a contract error
;; - That `step3` returns a list of (number, symbol) pairs
;;
;; We have provided sample contracts so the tests compile, but you
;;  will want to edit & strengthen these.
;;
;; (For example, things like 0.333 and 7/8 pass the `number?` contract
;;  but these functions expect integers and natural numbers)
;; ----------------------------------------------------------------------------



(provide (contract-out
          [step1 (-> (integer-in 0 99) string?)]
          ;; Convert a positive, 2-digit number to an English string

          [step2 (-> natural? (listof number?))]
          ;; Divide a large positive number into a list of 3-digit (or smaller) chunks

          [step3 (-> natural? (listof (cons/c number? symbol?)))]
          ;; Break a number into chunks and insert scales between the chunks

          [step4 (-> integer? string?)]
          ;; Convert a number to an English-language string
          ))

;; =============================================================================

(define *number-names*
  (make-immutable-hash '((0  . "zero")
                         (1  . "one")
                         (2  . "two")
                         (3  . "three")
                         (4  . "four")
                         (5  . "five")
                         (6  . "six")
                         (7  . "seven")
                         (8  . "eight")
                         (9  . "nine")
                         (10 . "ten")
                         (11 . "eleven")
                         (12 . "twelve")
                         (13 . "thirteen")
                         (14 . "fourteen")
                         (15 . "fifteen")
                         (16 . "sixteen")
                         (17 . "seventeen")
                         (18 . "eighteen")
                         (19 . "nineteen")
                         (20 . "twenty")
                         (30 . "thirty")
                         (40 . "forty")
                         (50 . "fifty")
                         (60 . "sixty")
                         (70 . "seventy")
                         (80 . "eighty")
                         (90 . "ninety"))))

(define *thousands* '(END thousand million billion trillion))

(define (step1 n)
  (cond [(hash-has-key? *number-names* n) (hash-ref *number-names* n)]
        [else (string-join (list (hash-ref *number-names* (* 10 (quotient n 10)))
                                 (hash-ref *number-names* (remainder n 10)))
                           "-")]))

(define (step2 N)
  (define (get-next-chunk n)
    (if ((abs n) . >= . 1000)
        (append (get-next-chunk (quotient n 1000)) (list (abs (remainder n 1000))))
        (list n)))
  (get-next-chunk N))

(define (step3 n)
  (reverse
   (for/list ([chunk (in-list (reverse (step2 n)))]
              [name (in-list *thousands*)])
     (cons chunk name))))

(define (step4 N)
  (define (process-chunk chunk)
    (define val (abs (car chunk)))
    (define name (cdr chunk))
    (string-join
     (filter (λ (n) (not (void? n)))
             (flatten (list
                       (when (negative? (car chunk)) "negative")
                       (when (>= val 100)
                         (list
                          (hash-ref *number-names* (quotient val 100))
                          "hundred"))
                       (unless (zero? (remainder val 100))
                         (step1 (remainder val 100)))
                       (when (not (equal? name 'END)) (symbol->string name)))))))
  (cond [(zero? N) "zero"]
        [else
         (string-join
          (for/list ([chunk (in-list (step3 N))]
                     #:when (not (zero? (car chunk))))
            (process-chunk chunk)))]))


