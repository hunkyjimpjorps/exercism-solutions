#lang racket

(provide annotate)

(struct Posn (x y) #:transparent)

(define (parse-field field)
  (for*/hash ([(row i) (in-indexed field)]
              [(col j) (in-indexed row)])
    (values (Posn j i) col)))

(define (posn-neighbors posn)
  (match-define (Posn x y) posn)
  (for*/list ([dx '(-1 0 1)]
              [dy '(-1 0 1)]
              #:unless (= 0 dx dy))
    (Posn (+ x dx) (+ y dy))))

(define (process-flowerfield field)
  (for/list ([(posn cell) (in-hash field)])
    (cond
      [(equal? cell #\*) (cons posn #\*)]
      [else (cons posn (count-neighboring-flowers posn field))])))

(define (count-neighboring-flowers posn field)
  (define sum
    (for/sum ([neighbor (in-list (posn-neighbors posn))] ;
              #:when (equal? #\* (hash-ref field neighbor #f)))
             1))
  (if (zero? sum)
      " "
      (~a sum)))

(define (annotate flowerfield)
  (let* ([flowerfield-hash (parse-field flowerfield)]
         [counts (process-flowerfield flowerfield-hash)]
         [sorted-rows (sort counts < #:key (λ (x) (Posn-x (car x))))]
         [sorted-cols (sort sorted-rows < #:key (λ (x) (Posn-y (car x))))]
         [grouped (group-by (λ (x) (Posn-y (car x))) sorted-cols)]
         [rows (map (λ (r) (apply ~a (map cdr r))) grouped)]
         [result (if (equal? flowerfield '(""))
                     '("")
                     rows)])
    result))
