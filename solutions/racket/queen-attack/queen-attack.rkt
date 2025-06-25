#lang racket

(provide create-queen
         can-attack?)

(struct Queen (row column)
  #:constructor-name create-queen
  #:guard (λ (r c _)
            (cond
              [(not (<= 0 r 7)) (error "row is outside board")]
              [(not (<= 0 c 7)) (error "column is outside board")]
              [else (values r c)])))

(define/match (can-attack? _white-queen _black-queen)
  [((Queen _r _) (Queen _r _)) #t]
  [((Queen _ _c) (Queen _ _c)) #t]
  [((Queen r1 c1) (Queen r2 c2)) (= (abs (- r1 r2)) (abs (- c1 c2)))])
