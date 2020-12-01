#lang racket

(require test-engine/racket-tests)

(define input (file->lines "./00input.txt"))
(check-expect (not (empty? input)) #true)

(print "The result is: ")

(test)
