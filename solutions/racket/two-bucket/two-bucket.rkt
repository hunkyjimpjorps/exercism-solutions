#lang racket

(provide measure)

(struct bucket-state (one two) #:transparent)
(struct bucket-path (state moves) #:transparent)

(define (measure max1 max2 goal start)
  (when (and (goal . > . max1) (goal . > . max2))
    (error "neither bucket is big enough to hold the goal amount"))
  ; emptying the starting bucket and filling the other bucket is invalid
  ; so add it to our set of impossible states
  (define no-go
    (match start
      ['one (set (bucket-state 0 max2))]
      ['two (set (bucket-state max1 0))]))

  (do-next-pour (list (bucket-path (bucket-state 0 0) 0)) no-go max1 max2 goal))

(define (do-next-pour pours no-go max1 max2 goal)
  (println no-go)
  (match pours
    ['() (error "exhausted all paths and couldn't find the goal")]
    ; we're finished if either bucket holds the goal amount
    [(list* (bucket-path (bucket-state (== goal) two) moves) _) (list moves 'one two)]
    [(list* (bucket-path (bucket-state one (== goal)) moves) _) (list moves 'two one)]
    ; otherwise, remove the current move and append all the possible next moves
    [(list* (bucket-path state moves) rest-pours)
     (define next
       (append rest-pours
               (for/list ([maybe (in-list (find-next-pours state max1 max2))]
                          #:unless (set-member? no-go maybe))
                 (bucket-path maybe (add1 moves)))))
     (define next-no-go (set-add no-go state))
     (do-next-pour next next-no-go max1 max2 goal)]))

(define (find-next-pours state max1 max2)
  (match-define (bucket-state one two) state)
  (define next
    ; there are six possible moves that can be made:
    (list (bucket-state 0 two) ; empty the first bucket
          (bucket-state one 0) ; empty the second bucket
          (bucket-state max1 two) ; fill the first bucket
          (bucket-state one max2) ; fill the second bucket
          (if (one . < . (- max2 two)) ; pour the first bucket into the second
              (bucket-state 0 (+ one two))
              (bucket-state (- one (- max2 two)) max2))
          (if (two . < . (- max1 one)) ; pour the second bucket into the first
              (bucket-state (+ one two) 0)
              (bucket-state max1 (- two (- max1 one))))))
  (remove-duplicates next))
