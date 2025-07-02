#lang racket

(provide robot%)

(define robot%
  (class object%
    (super-new)
    (init-field position direction)

    (define/public (move moves)
      (for ([move (in-string moves)])
        (match move
          [#\A (advance)]
          [#\L (rotate-left)]
          [#\R (rotate-right)])))

    (define (advance)
      (match-define (list x y) position)
      (set! position
            (match direction
              ['north (list x (add1 y))]
              ['east (list (add1 x) y)]
              ['south (list x (sub1 y))]
              ['west (list (sub1 x) y)])))

    (define (rotate-left)
      (set! direction
            (match direction
              ['north 'west]
              ['east 'north]
              ['south 'east]
              ['west 'south])))

    (define (rotate-right)
      (set! direction
            (match direction
              ['north 'east]
              ['east 'south]
              ['south 'west]
              ['west 'north])))))
