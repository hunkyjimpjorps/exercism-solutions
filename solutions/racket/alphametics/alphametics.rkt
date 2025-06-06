#lang racket

(require racket/hash)
(provide solve)
(struct puzzle (left-side right-side vars firsts) #:transparent)

(define (solve str)
  (define p (parse-raw-puzzle str))

  (define left-side-values (total-value-of-words (puzzle-left-side p)))
  (define right-side-values (total-value-of-words (puzzle-right-side p)))
  (define balanced-values
    (for/fold ([place-values left-side-values]) ([(c v*) (in-hash right-side-values)])
      (hash-update place-values c (λ (v) (- v v*)) 0)))

  (define solution
    (for*/first ([combos (in-combinations (range 10) (length (puzzle-vars p)))]
                 [vals (in-permutations combos)]
                 #:do [(define assigns
                         (make-immutable-hash (map (λ (k v) (cons k v)) (puzzle-vars p) vals)))]
                 #:unless (findf (λ (k) (= (hash-ref assigns k) 0)) (puzzle-firsts p))
                 #:do [(define sum
                         (apply + (hash-values (hash-union assigns balanced-values #:combine *))))]
                 #:when (= sum 0))
      (map (λ (c) (cons (string c) (hash-ref assigns c))) (puzzle-vars p))))

  (match solution
    [#f '()]
    [s s]))

(define (parse-raw-puzzle p)
  (define words (string-split p #px" (\\+|==) "))
  (define variables (find-variables words))
  (define firsts (find-firsts words))
  (puzzle (drop-right words 1) (list (last words)) variables firsts))

(define (find-variables ws)
  (define joined-words (string-join ws ""))
  (remove-duplicates (string->list joined-words)))

(define (find-firsts ws)
  (remove-duplicates (map (λ (w) (string-ref w 0)) ws)))

(define (place-value-of-word w)
  (define val-map (make-hash))
  (for ([(c i) (in-indexed (in-list (reverse (string->list w))))])
    (hash-update! val-map c (λ (v) (+ v (expt 10 i))) 0))
  (make-immutable-hash (hash->list val-map)))

(define (total-value-of-words ws)
  (apply hash-union (map place-value-of-word ws) #:combine +))
