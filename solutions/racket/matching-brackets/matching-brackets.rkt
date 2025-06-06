#lang racket

(provide balanced?)

(define (balanced? str)
  (do-balanced (string->list (regexp-replace* #px"[^\\(\\)\\[\\]\\{\\}]" str ""))))

(define/match (do-balanced chrs [acc '()])
  [('() '()) #true]
  [((list* h t) acc)
   #:when (member h (string->list "([{"))
   (do-balanced t (cons h acc))]
  [((list* h t) (list* acc-h acc-t))
   #:when (member (string acc-h h) '("()" "[]" "{}"))
   (do-balanced t acc-t)]
  [(_ _) #false])
