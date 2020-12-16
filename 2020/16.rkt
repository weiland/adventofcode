#lang racket

(require test-engine/racket-tests)

(define DAY "16")
(define raw-input (file->string (string-append "./input/" DAY ".txt")))
(define input (string-split raw-input "\n\n"))
(check-expect (length input) 3)
(check-expect (length (string-split (car input) "\n")) 20)

(define raw-rules (string-split (car input) "\n"))
(define (get-min-max rule) (map string->number (string-split rule "-")))
(define SIMPLE-RULES
  (apply append
         (map
           (lambda (row)
             (map
               get-min-max
               (string-split (string-replace row #px"(.*): " "") " or ")))
           raw-rules)))
(check-expect (length SIMPLE-RULES) 40)

(define rules-ht (foldl (lambda (rule ht)
                          (define pair (string-split rule ": "))
                          (define key (car pair))
                          (define value-pair (string-split (car (cdr pair)) " or "))
                          (hash-set ht key value-pair)
                          ) (hash) raw-rules))

(check-expect (hash-count rules-ht) 20)
(check-expect (hash-ref rules-ht "departure location") '("26-715" "727-972"))

(define my-ticket
  (map string->number
       (string-split (string-replace (car (cdr input)) #px"(.*)\n" "") ",")))

(define nearby-tickets
  (cdr (map
    (lambda (row) (map string->number (string-split row ",")))
    (string-split (car (cdr (cdr input))) "\n"))))

(define (calc rule num)
  (and (<= (car rule) num) (>= (second rule) num)))

(define (get-invalid-field ticket)
  (filter values
    (map (lambda (num)
          (if (foldl (lambda (rule result)
            (if result #t
              (calc rule num)
              )) #f SIMPLE-RULES)
              #f num)) ticket)))

(define (calculate-error-rate tickets)
  (apply + (flatten (map (lambda (ticket) (get-invalid-field ticket)) nearby-tickets))))
(calculate-error-rate nearby-tickets)
(check-expect (calculate-error-rate nearby-tickets) 21081)


(define valid-tickets
  (filter (lambda (ticket) (empty? (get-invalid-field ticket))) nearby-tickets))

;; transpose the tickets list
(define fields (map (lambda (position)
      (foldr (lambda (ticket fields)
              (cons (list-ref ticket position) fields)
              ) empty valid-tickets)
  ) (build-list (length (car valid-tickets)) values)))

;; check how many rules apply to one (of 20) field
(define vals (map (lambda (field-values)
       (filter values (map (lambda (rule)
              (if (andmap (lambda (val)
                        (or
                          (calc (get-min-max (car (cdr rule))) val)
                          (calc (get-min-max (second (cdr rule))) val)
                        )
                        )
                      field-values) (car rule) #f))
              (hash->list rules-ht))))
     fields))

(define sorted (sort vals #:key length <))

(define (clean lst keys)
  (cond
    [(empty? lst) keys]
    ; [(empty? (cdr lst)) (append keys (car lst))]
    [else (clean (cdr lst) (append keys (filter-not (lambda (i) (member i keys)) (car lst))))]
    )
  )

(define my-departure-values
  (map (lambda (i)
         (list-ref my-ticket (index-of vals (list-ref sorted i))))
       (indexes-where (clean sorted empty) (lambda (i) (string-prefix? i "departure")))))

;; solution part two
(apply * my-departure-values)

(test)
