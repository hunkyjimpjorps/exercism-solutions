#lang racket

(provide color-code)

(define color-list
  (list "black" "brown" "red" "orange" "yellow" "green" "blue" "violet" "grey" "white"))

(define color-hash
  (for/hash ([c (in-list color-list)] [n 10])
    (values c n)))

(define (color-val c)
  (hash-ref color-hash c))

(define (parse-color-list colors)
  (match colors
    [(list c1 c2 c3 _ ...) (* (+ (* 10 (color-val c1)) (color-val c2)) (expt 10 (color-val c3)))]))

(define (display-resistance r)
  (if (zero? r)
      "0 ohms"
      (for/first ([pow (list 9 6 3 0)]
                  [prefix (list "giga" "mega" "kilo" "")]
                  #:do [(define mantissa (/ r (expt 10 pow)))]
                  #:when (integer? mantissa))
        (~a mantissa " " prefix "ohms"))))

(define (color-code colors)
  (display-resistance (parse-color-list colors)))
