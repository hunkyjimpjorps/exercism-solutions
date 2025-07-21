#lang racket

(provide bank-account%)

(define bank-account%
  (class object%
    (super-new)
    (init-field [status 'closed] [current-balance 0] [lock (make-semaphore 1)])

    (define (is-open?)
      (equal? status 'open))

    (define/public (open)
      (semaphore-wait lock)
      (cond
        [(is-open?) (error "account already open")]
        [else (set! status 'open)])
      (semaphore-post lock))

    (define/public (close)
      (semaphore-wait lock)
      (cond
        [(is-open?)
         (set! status 'closed)
         (set! current-balance 0)]
        [else (error "account not open")])
      (semaphore-post lock))

    (define/public (balance)
      (semaphore-wait lock)
      (cond
        [(is-open?) current-balance]
        [else (error "account not open")])
      (semaphore-post lock))

    (define/public (deposit amount)
      (semaphore-wait lock)
      (cond
        [(not (is-open?)) (error "account not open")]
        [(negative? amount) (error "amount must be greater than 0")]
        [else (set! current-balance (+ current-balance amount))])
      (semaphore-post lock))

    (define/public (withdraw amount)
      (semaphore-wait lock)
      (cond
        [(not (is-open?)) (error "account not open")]
        [(negative? amount) (error "amount must be greater than 0")]
        [(current-balance . < . amount) (error "amount must be less than balance")]
        [else (set! current-balance (- current-balance amount))])
      (semaphore-post lock))))
