#lang racket

(provide rebase)

(define (rebase list-digits in-base out-base)
  (define (to-base-10 ns b)
    (apply + (map (λ (n i) (* n (expt b i)))
                  ns
                  (range (sub1 (length ns)) -1 -1))))
  (define (find-max-base n b [pow 0])
    (if (n . > . (expt b (add1 pow)))
        (find-max-base n b (add1 pow))
        pow))
  (define (to-new-base n b max-base)
    (for/fold ([digits '()]
               [remaining n]
               #:result digits)
              ([i (range max-base -1 -1)])
      (values (append digits (list (quotient remaining (expt b i))))
              (remainder remaining (expt b i)))))
  (cond [(or (= out-base 1)
             (= out-base 0)
             (= in-base 1)
             (= in-base 0)
             (not (empty? (filter negative? list-digits)))
             (not (empty? (filter (λ (n) (n . >= . in-base)) list-digits)))
             (negative? out-base)
             (negative? in-base)) #false]
        [(empty? list-digits) '(0)]
        [(match list-digits
           [(list 0 0 ...) #true]
           [else #false]) '(0)]
        [else
         (define base-10-number (to-base-10 list-digits in-base))
         (to-new-base base-10-number out-base (find-max-base base-10-number out-base))]))