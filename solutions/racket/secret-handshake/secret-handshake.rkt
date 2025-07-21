#lang racket

(provide commands)

(define (commands code)
  (for/lists (output #:result (match output
                                [(list* 'reverse xs) xs]
                                [xs (reverse xs)]))
             ([bit (in-string (~r code #:base 2 #:min-width 5 #:pad-string "0"))]
              [command (list 'reverse "jump" "close your eyes" "double blink" "wink")]
              #:when (equal? bit #\1))
             command))
