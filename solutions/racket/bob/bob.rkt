#lang racket

(provide response-for)

(define (response-for said)
  (define said-in-caps (string-upcase said))
  (define said-no-letters? (not (regexp-match #px"[[:alpha:]]" said)))
  (cond [(equal? "" (string-trim said)) "Fine. Be that way!"]
        [(and said-no-letters?
              (string-suffix? said "?")) "Sure."]
        [said-no-letters? "Whatever."]
        [(and (equal? said said-in-caps)
              (string-suffix? said "?")) "Calm down, I know what I'm doing!"]
        [(equal? said said-in-caps) "Whoa, chill out!"]
        [(string-suffix? said "?") "Sure."]
        [else "Whatever."]))