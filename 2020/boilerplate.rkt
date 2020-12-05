#lang racket

(require test-engine/racket-tests)

(define DAY "0")

(define test-list '())
(define expected-number 7)

(define input (file->lines (string-append "./input/" DAY ".txt")))

(check-expect (not (empty? input)) #true)


(define result1 '())

(println "Part 1 result is: ")
(println result1)


(define result2 '())

(println "Part 2 result is: ")
(println result2)

(test)
