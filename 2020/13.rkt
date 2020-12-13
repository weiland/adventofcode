#lang racket

(require test-engine/racket-tests)
;; (require racket/trace)

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

;; if bus-id is returned bus departs at given timestamp otherwise #f
(define (check-bus timestamp bus-id)
  (if (zero? (modulo timestamp bus-id)) bus-id #f))

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

(println input)

(define result1 (solve-part-one (first input) (rest input)))

(println "Part 1 result is: ")
(println result1)


(define result2 '())

(println "Part 2 result is: ")
(println result2)

(check-expect (check-bus 939 59) #f)
(check-expect (check-bus 944 59) 59)



(test)
