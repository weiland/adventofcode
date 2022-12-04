#lang racket

; (require test-engine/racket-tests)

;; input
(define total-calories (file->string "./input/01.txt"))

(define (calc-total input) (foldl + 0 (map string->number (string-split input "\n"))))

(define elves (map calc-total (string-split total-calories "\n\n")))

(define max-value (apply max elves))

(define max-values (foldl + 0 (take (sort elves >) 3)))

;; part one
(println max-value)

;; part two
(println max-values)

; (test)
