#lang racket

(require test-engine/racket-tests)

(define day "02")
(define file (string-append day ".rkt"))

(require "02.rkt")


(define input (file->lines (string-append "./i" day ".txt")))
(check-expect (not (empty? input)) #true)

(println "The result is: ")

(test)
