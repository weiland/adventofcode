#lang racket
(require test-engine/racket-tests)

(define INPUT '(9 6 0 10 18 2 1))
(define MAX_TURN 2020)
(define MAX_TURN-TWO 30000000)

;; sounds like van eck?

(define (solve-part-one lst max-turn)
  (define current-number (last lst))
  (define indexes (indexes-of lst current-number))
  (define num (if (>= (length indexes) 2) (apply - (take (reverse indexes) 2)) 0))
  (if (>= (length lst) max-turn)
      current-number
      (solve-part-one (append lst (list num)) max-turn)))

;; improved version
(define (solve-part-one-rev lst max-turn)
  (let ((indexes (indexes-of lst (car lst))))
    (if (>= (length lst) max-turn)
        (car lst)
        (solve-part-one-rev
          (cons
            (if (>= (length indexes) 2) (apply - (reverse (take indexes 2))) 0)
            lst) max-turn))))

;; version using hashtables?

(check-expect (solve-part-one '(0 3 6) 10) 0)
(check-expect (solve-part-one '(1 3 2) MAX_TURN) 1)
(check-expect (solve-part-one '(2 1 3) MAX_TURN) 10)
(check-expect (solve-part-one '(1 2 3) MAX_TURN) 27)
(check-expect (solve-part-one '(2 3 1) MAX_TURN) 78)
(check-expect (solve-part-one '(3 2 1) MAX_TURN) 438)
(check-expect (solve-part-one '(3 1 2) MAX_TURN) 1836)
  

(check-expect (solve-part-one-rev '(2 3 1) MAX_TURN) 1)
(check-expect (solve-part-one-rev '(3 1 2) MAX_TURN) 10)
(check-expect (solve-part-one-rev '(3 2 1) MAX_TURN) 27)

(define result1 (solve-part-one INPUT MAX_TURN))

(println "Part 1 result is: ")
(println result1)

; (check-expect (solve-part-one '(3 2 1) 30000000) 18)
(define result2 (solve-part-one-rev (reverse INPUT) 30000000))

(println "Part 2 result is: ")
(println result2)

(test)
