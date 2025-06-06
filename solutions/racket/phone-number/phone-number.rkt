#lang racket

(provide nanp-clean)

(define (nanp-clean s)
  (define digits-raw (string-replace s #rx"[^0-9]" ""))
  (define digits-only (if (string-prefix? digits-raw "1")
                          (substring digits-raw 1)
                          digits-raw))
  (let ([digits-length (string-length digits-only)]
        [area-code-prefix (substring digits-only 0 1)]
        [exchange-prefix (substring digits-only 3 4)])
    (cond [(not (= digits-length 10)) (raise-arguments-error 'bad-length
                                                             "Too many or too few digits")]
          [(member area-code-prefix '("0" "1")) (raise-arguments-error 'bad-area-code
                                                                       "Invalid area code")]
          [(member exchange-prefix '("0" "1")) (raise-arguments-error 'bad-exchange
                                                                      "Invalid exchange")]
          [else digits-only])))