#lang racket

(provide grep)

(define (flags-contain? flags f)
  (member flags f))

(define (grep flags pattern file-list)
  (define (flags-contain? f)
    (member f flags))
  
  (define case-insensitive? (flags-contain? "-i"))
  (define print-names-only? (flags-contain? "-l"))
  (define add-line-numbers? (flags-contain? "-n"))
  (define invert-search?    (flags-contain? "-v"))
  (define match-lines-only? (flags-contain? "-x"))
  (define multiple-files?   (< 1 (length file-list)))
  (define one-line-matched? #false)

  (define (string-match? s contained)
    (define proc
      (if match-lines-only?
          string=?
          string-contains?))
    (if case-insensitive?
        (proc (string-downcase s) (string-downcase contained))
        (proc s contained)))
  
  (flatten
   (for/list ([search-file (in-list file-list)])
     (when print-names-only? (set! one-line-matched? #false))
     (call-with-input-file search-file
       (λ (in)
         (for/list ([file-line (in-port read-line in)]
                    [line-number (in-naturals 1)]
                    #:break one-line-matched?
                    #:when (if invert-search?
                               (not (string-match? file-line pattern))
                               (string-match? file-line pattern)))
           (when print-names-only? (set! one-line-matched? #true))
           (string-join
            (filter-not void?
                        (list (when (or multiple-files?
                                        print-names-only?) search-file)
                              (when add-line-numbers? (~a line-number))
                              (unless print-names-only? file-line)))
            ":")))))))