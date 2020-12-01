#lang racket
(require test-engine/racket-tests)

(require "03.rkt")



(define file (file->lines "./03input.txt"))

(define (handle-row row)
    (string-split row ",")
)
(define input (map handle-row file))

(check-expect (not (empty? file)) #t)
(check-expect (not (empty? input)) #t)
(check-expect (length input) 2)

(define result-part1 (answer-part1 input))
;;; (define result-part2 (answer-part2 input))

;;; (check-expect (> result-part1 1) #t)
;;; (check-expect (> result-part2 1) #t)

; expect 5305097
;;; (check-expect result-part1 5305097)
; expect 4925
;;; (check-expect result-part2 4925)

(test)

(println input)
;;; (println result-part2)
