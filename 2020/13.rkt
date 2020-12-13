#lang racket
(require math/number-theory)
(require test-engine/racket-tests)
; (require racket/trace)

(define DAY "13")

(define (parse-possible-numbers lst)
  (map string->number (filter (lambda (item) (not (equal? "x" item))) lst)))

(define test-list (parse-possible-numbers (list "939" "7" "13" "x" "x" "59" "x" "31" "19")))

(define raw-input (file->lines (string-append "./input/" DAY ".txt")))
(check-expect (length raw-input) 2)
(define input (cons
                (string->number (first raw-input))
                (parse-possible-numbers (string-split (second raw-input) ","))))
(check-expect (not (empty? input)) #t)

(define input-two
  (map (lambda (item)
         (if (equal? "x" item) "x" (string->number item)))
       (string-split (second raw-input) ",")))

;; if bus-id is returned bus departs at given timestamp otherwise #f
(define (check-bus timestamp bus-id)
  (if (zero? (modulo timestamp bus-id)) bus-id #f))

(check-expect (check-bus 939 59) #f)
(check-expect (check-bus 944 59) 59)

(define (filter-buses timestamp buses)
  (filter identity (map (lambda (bus) (check-bus timestamp bus)) buses)))

(check-expect (filter-buses (first test-list) (rest test-list)) '())
(check-expect (filter-buses 938 (rest test-list)) '(7))
(check-expect (filter-buses 944 (rest test-list)) '(59))

(define (find-bus earliest-timestamp timestamp buses)
  (let
    ((result (filter-buses timestamp buses)))
    (if (zero? (length result))
        (find-bus earliest-timestamp (+ 1 timestamp) buses)
        (list (first result) (- timestamp earliest-timestamp)))))

(check-expect (find-bus (first test-list) (first test-list) (rest test-list)) (list 59 5))

(define (solve-part-one earliest-timestamp buses)
  (apply * (find-bus earliest-timestamp earliest-timestamp buses)))

(check-expect (solve-part-one (first test-list) (rest test-list)) (* 59 5))

(define result1 (solve-part-one (first input) (rest input)))

(println "Part 1 result is: ")
(println result1)

;; part two: (chinese remainder theorem it is?): recursive attempt
(define (find-time start-time lst)
  (cond
    [(empty? lst) (error "list is empty")]
    ;; first make sure that the first item is a number (and not x), assumption: the last item is not x (there is a rest)
    [(equal? (first lst) "x") (find-time (+ 1 start-time) (rest lst))]
    ;; second make sure that the first list item divides the start-time
    [(not (zero? (modulo start-time (first lst)))) #f]
    ;; third if there are not items left we are done
    [(empty? (rest lst)) start-time]
    ;; if the next item is truthy (returns a number and not #f) we got the start-time
    [(find-time (+ 1 start-time) (rest lst)) start-time]
    ;; increase the start-time and re-try
    [else (find-time (+ start-time (first lst)) lst)]))

; (check-error (find-time 4 '()) "list is empty")
; (check-expect (find-time 0 '(4)) 0)
; (check-expect (find-time 4 '(4)) 4)
; (check-expect (find-time 4 '(4 5 6)) 4)
; (check-expect (find-time 4 '(4 6)) 4)
; (check-expect (find-time 4 '(4 "x" 6)) 4)
; (check-expect (find-time 17 '(17 "x" 13 19)) 3417)

; (define (find-start-position lst)
;   (* (first lst) (ceiling (/ (apply max (filter (lambda (item) (not (equal? "x" item))) lst)) (first lst)))))

; (define (solve-part-two buses)
;   (find-time (find-start-position buses) buses))

;; turns out racket provides a function \o/

(define (numbers-only item)
 (not (equal? item "x")))

(check-expect (indexes-where input-two numbers-only) '(0 3 13 15 32 36 44 50 61))

(define (get-bus-distance bus buses)
  (cond
    [(equal? 0 bus) bus]
    [else (- (list-ref buses bus) bus)]))

(define (solve-part-two buses)
  (solve-chinese
    (map (lambda (bus) (get-bus-distance bus buses))
         (indexes-where buses numbers-only))
    (filter numbers-only buses)))

(define result2 (solve-part-two input-two))
(println "Part 2 result is: ")
(println result2)

(test)
