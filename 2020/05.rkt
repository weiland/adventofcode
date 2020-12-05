#lang racket

(require test-engine/racket-tests)

(define DAY "5")

(define test-list '())
(define expected-number 7)

(define passes (file->lines (string-append "./input/" DAY ".txt")))

(check-expect (not (empty? passes)) #true)

(define (row-part str) (substring str 0 7))
(define (col-part str) (substring str 7 10))

(check-expect (row-part "FBFBBFFRLR") "FBFBBFF")
(check-expect (col-part "FBFBBFFRLR") "RLR")

(define (row str) (string->number (string-replace (string-replace (row-part str) "F" "0") "B" "1") 2))
(define (col str) (string->number (string-replace (string-replace (col-part str) "L" "0") "R" "1") 2))
(define (seat str) (+ (* (row str) 8) (col str)))

(check-expect (row "FBFBBFFRLR") 44)
(check-expect (col "FBFBBFFRLR") 5)
(check-expect (seat "FBFBBFFRLR") 357)
(check-expect (row "BFFFBBFRRR") 70)
(check-expect (col "BFFFBBFRRR") 7)
(check-expect (seat "BFFFBBFRRR") 567)
(check-expect (row "FFFBBBFRRR") 14)
(check-expect (col "FFFBBBFRRR") 7)
(check-expect (seat "FFFBBBFRRR") 119)
(check-expect (row "BBFFBBFRLL") 102)
(check-expect (col "BBFFBBFRLL") 4)
(check-expect (seat "BBFFBBFRLL") 820)

(check-expect (max 1 2 3) 3)
(check-expect (apply max '(1 2 3)) 3)

(define (highest-set-id lst) (apply max (map seat lst)))

(check-expect (highest-set-id '("FBFBBFFRLR" "FFFBBBFRRR" "BBFFBBFRLL")) 820)


(define result1 (highest-set-id passes))


(println "Part 1: The highest seat ID: ")
(println result1)

(define seats (map seat passes))

(define result2 (first (filter (lambda (n) n) (map (lambda (num) 
                (if (not (member num seats)) num #f)
                ) (range 61 994)))))



(println "Part 2 result is: ")
(println result2)

(test)
