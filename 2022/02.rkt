#lang racket

(require test-engine/racket-tests)
;; (require racket/trace)

(define DAY "02")

(define raw-lines (file->lines (string-append "./input/" DAY ".txt")))

(define (convert letter)
  (cond
    [(or (equal? letter "A") (equal? letter "X")) 1] ; Rock
    [(or (equal? letter "B") (equal? letter "Y")) 2] ; Paper
    [(or (equal? letter "C") (equal? letter "Z")) 3] ; Scissors
    [else (error "invalid input letter to convert")]))

(define (convert-line line) (map convert (string-split line " ")))

(define input (map convert-line raw-lines))

;; Rock (1) defeats Scissors (3),
;; Scissors (3) defeats Paper (2), and
;; Paper (2) defeats Rock (1)
(define (calculate-score line)
  (cond
    [(and (equal? (first line) 1) (equal? (second line) 1)) 4] ; draw
    [(and (equal? (first line) 1) (equal? (second line) 2)) 8] ; i won (paper defeats rock)
    [(and (equal? (first line) 1) (equal? (second line) 3)) 3] ; i loose (rock defeats scissors)
    [(and (equal? (first line) 2) (equal? (second line) 1)) 1] ; i loose
    [(and (equal? (first line) 2) (equal? (second line) 2)) 5] ; draw
    [(and (equal? (first line) 2) (equal? (second line) 3)) 9] ; i win
    [(and (equal? (first line) 3) (equal? (second line) 1)) 7] ; i win
    [(and (equal? (first line) 3) (equal? (second line) 2)) 2] ; i loose
    [(and (equal? (first line) 3) (equal? (second line) 3)) 6] ; draw
    [else (error "invalid option")]
    ))

(println (foldl + 0 (map calculate-score input)))

(check-expect (not (empty? input)) #t)



(define result1 '())

(println "Part 1 result is: ")
(println result1)


(define result2 '())

(println "Part 2 result is: ")
(println result2)

(test)
