#lang racket

(provide encode decode)
(require (only-in threading
                  ~>
                  λ~>))

(define (encode . nums)
  (define (to-new-base n b)
    (define (find-max-base n b [pow 0])
      (if (n . >= . (expt b (add1 pow)))
          (find-max-base n b (add1 pow))
          pow))
    (for/fold ([digits '()]
               [remaining n]
               #:result digits)
              ([i (in-inclusive-range (find-max-base n b) 0 -1)])
      (values (append digits (list (quotient remaining (expt b i))))
              (remainder remaining (expt b i)))))
  (define (encode-one num)
    ; to produce the VLQ octets, convert to base 128, make an octet for each digit,
    ; and flip the 128 bit for all but the last octet
    (define digits (to-new-base num 128))
    (if (= 1 (length digits))
        digits
        (append (map (λ~> (bitwise-ior 128)) (drop-right digits 1))
                (take-right digits 1))))
  (flatten (map encode-one nums)))

(define (decode . nums)
  (define to-decode-list
    (for/fold ([to-decode '()] ; list of VLQ octet sets
               [acc '()] ; accumulator to gather octet sets
               ; if there's still octets left in acc at the end of the list comprehension
               ; the octet stream is incomplete; raise an error
               #:result (if (not (empty? acc))
                            (raise-arguments-error 'incomplete-vlq
                                                   "no final octet in VLQ sequence"
                                                   "incomplete sequence" acc)
                            (reverse to-decode)))
              ([digit (in-list nums)])
      (if (bitwise-bit-set? digit 7)
          ; if it's not an ending octet, keep the current list of numbers
          ; and add the octet to the accumulator after flipping its 128 bit to false
          (values to-decode ; -> to-decode
                  (~> digit
                    (bitwise-xor 128)
                    (cons _ acc))) ; -> acc
          ; if it's an ending octet, add the complete octet set to the list of numbers
          ; and clear the accumulator
          (values (~> digit
                    (cons _ acc)
                    (cons _ to-decode)) ; -> to-decode
                  '())))) ; -> acc
  (for/list ([to-decode (in-list to-decode-list)])
    (for/sum ([digit (in-list to-decode)]
              [n (in-naturals)])
      (* digit (expt 128 n)))))

