#lang racket

(require test-engine/racket-tests)
;; (require racket/trace)

(define DAY "02")

(define raw-lines (file->lines (string-append "./input/" DAY ".txt")))

(define (convert-line line) (string-split line " "))

(define input (map convert-line raw-lines))

;; Rock (A) defeats Scissors (C),
;; Scissors (C) defeats Paper (B), and
;; Paper (B) defeats Rock (A)
(define (calculate-score line)
  (cond
    [(and (equal? (first line) "A") (equal? (second line) "X")) 4] ; draw
    [(and (equal? (first line) "A") (equal? (second line) "Y")) 8] ; i won (paper defeats rock)
    [(and (equal? (first line) "A") (equal? (second line) "Z")) 3] ; i loose (rock defeats scissors)
    [(and (equal? (first line) "B") (equal? (second line) "X")) 1] ; i loose
    [(and (equal? (first line) "B") (equal? (second line) "Y")) 5] ; draw
    [(and (equal? (first line) "B") (equal? (second line) "Z")) 9] ; i win
    [(and (equal? (first line) "C") (equal? (second line) "X")) 7] ; i win
    [(and (equal? (first line) "C") (equal? (second line) "Y")) 2] ; i loose
    [(and (equal? (first line) "C") (equal? (second line) "Z")) 6] ; draw
    [else (error "invalid option")]
    ))

;; X loose
;; Y draw
;; Z win
(define (calculate-score-two line)
  (cond
    [(and (equal? (first line) "A") (equal? (second line) "X")) 3] ; loose
    [(and (equal? (first line) "A") (equal? (second line) "Y")) 4] ; draw
    [(and (equal? (first line) "A") (equal? (second line) "Z")) 8] ; win
    [(and (equal? (first line) "B") (equal? (second line) "X")) 1] ; loose
    [(and (equal? (first line) "B") (equal? (second line) "Y")) 5] ; draw
    [(and (equal? (first line) "B") (equal? (second line) "Z")) 9] ; win
    [(and (equal? (first line) "C") (equal? (second line) "X")) 2] ; loose
    [(and (equal? (first line) "C") (equal? (second line) "Y")) 6] ; draw
    [(and (equal? (first line) "C") (equal? (second line) "Z")) 7] ; win
    [else (error "invalid option")]
    ))


(check-expect (not (empty? input)) #t)



(define result1 (foldl + 0 (map calculate-score input)))

(println "Part 1 result is: ")
(println result1)


(define result2 (foldl + 0(map calculate-score-two input)))

(println "Part 2 result is: ")
(println result2)

(test)
