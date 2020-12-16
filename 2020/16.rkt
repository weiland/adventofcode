#lang racket

(require test-engine/racket-tests)

(define DAY "16")
(define raw-input (file->string (string-append "./input/" DAY ".txt")))
(define input (string-split raw-input "\n\n"))
(check-expect (length input) 3)
(check-expect (length (string-split (car input) "\n")) 20)

(define rules
  (apply append
         (map
           (lambda (row)
             (map
               (lambda (rule)
                 (map string->number (string-split rule "-")))
               (string-split (string-replace row #px"(.*): " "") " or ")))
           (string-split (car input) "\n"))))
(check-expect (length rules) 40)

(define my-ticket (car (cdr input)))

(define nearby-tickets
  (cdr (map
    (lambda (row) (map string->number (string-split row ",")))
    (string-split (car (cdr (cdr input))) "\n"))))

(define (calculate-error-rate tickets rules)
  (apply + (flatten (map (lambda (ticket)
         (filter values (map (lambda (num)
                 (if (foldl (lambda (rule result)
                    (if result #t
                      (and (<= (car rule) num) (>= (second rule) num))
                      )) #f rules)
                     #f num)) ticket))) nearby-tickets))))

(calculate-error-rate nearby-tickets rules)

(test)
