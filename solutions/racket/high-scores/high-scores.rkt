#lang racket

(provide high-scores%)

(define high-scores%
  (class object%
    (init values)
    (define current-values values)

    (super-new)

    (define/public (scores) current-values)
    (define/public (latest) (last current-values))
    (define/public (personal-best) (apply max current-values))
    (define/public (personal-top-three)
      (match (sort current-values >)
        [(list-rest a b c _) (list a b c)]
        [shorter shorter]))))
