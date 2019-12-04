#lang racket
(require test-engine/racket-tests)

(require "02.rkt")

(check-expect (parser 0 '()) '())
(check-expect (parser 0 '(99)) '(99))
(check-expect (parser 0 '(1 0 0 3 99)) '(1 0 0 2 99))
(check-expect (parser 0 '(2 0 0 3 99)) '(2 0 0 4 99))
(check-expect (parser 0 '(2 3 3 0 99)) '(0 3 3 0 99))
(check-expect (parser 0 '(1 3 3 0 99)) '(0 3 3 0 99))
(check-expect (parser 0 '(1 3 3 0 1 3 3 0 99)) '(0 3 3 0 1 3 3 0 99))
(check-expect (parser 0 '(1 0 0 3 1 0 0 0 99)) '(2 0 0 2 1 0 0 0 99))
(check-expect (parser 0 '(1 9 10 3 2 3 11 0 99 30 40 50)) '(3500 9 10 70 2 3 11 0 99 30 40 50))
(check-expect (parser 0 '(2 4 4 5 99 0)) '(2 4 4 5 99 9801))
(check-expect (parser 0 '(1 1 1 4 99 5 6 0 99)) '(30 1 1 4 2 5 6 0 99))
(check-expect (run '(1 9 10 3 2 3 11 0 99 30 40 50 60)) '(3100 12 2 62 2 3 11 0 99 30 40 50 60))


(define file (file->string "./i02.txt"))

(define input (map string->number (string-split (string-replace file "\n" "") ",")))
(check-expect (not (empty? input)) #true)


(define result-part1 (answer-part1 input))
(define result-part2 (answer-part2 input))

(check-expect (> result-part1 1) #t)
(check-expect (> result-part2 1) #t)

; expect 5305097
(check-expect result-part1 5305097)
; expect 4925
(check-expect result-part2 4925)

(test)

(println result-part1)
(println result-part2)
