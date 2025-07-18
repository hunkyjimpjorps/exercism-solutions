#lang racket

(provide recite)

(struct animal (name epithet terminal exception))

(define animals
  (list (animal "fly" "I don't know why she swallowed the fly. Perhaps she'll die." #t #f)
        (animal "spider"
                "It wriggled and jiggled and tickled inside her."
                #f
                "spider that wriggled and jiggled and tickled inside her")
        (animal "bird" "How absurd to swallow a bird!" #f #f)
        (animal "cat" "Imagine that, to swallow a cat!" #f #f)
        (animal "dog" "What a hog, to swallow a dog!" #f #f)
        (animal "goat" "Just opened her throat and swallowed a goat!" #f #f)
        (animal "cow" "I don't know how she swallowed a cow!" #f #f)
        (animal "horse" "She's dead, of course!" #t #f)))

(define final-line (animal-epithet (first animals)))

(define (recite start-verse end-verse)
  (flatten
   (add-between
    (for/list ([verse (in-inclusive-range start-verse end-verse)])
      (recite-verse verse))
    "")))

(define (recite-verse n)
  (define subset (reverse (take animals n)))
  (match-define (animal latest-animal latest-epithet terminal? _) (first subset))

  (for/lists
   [chain
    #:result (flatten (list (~a "I know an old lady who swallowed a " latest-animal ".")
                            latest-epithet
                            (if (empty? chain) '() (list chain final-line))))]
   (#:break terminal? [predator (in-list subset)] [prey (in-list (rest subset))])
    (~a "She swallowed the "
        (animal-name predator)
        " to catch the "
        (cond [(animal-exception prey)] [(animal-name prey)])
        ".")))
