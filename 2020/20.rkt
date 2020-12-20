#lang racket

(require test-engine/racket-tests)
;; (require racket/trace)

(define DAY "20")
(define input (string-split (file->string (string-append "./input/" DAY ".txt")) "\n\n"))

(define-struct tile (id rows))

(define (parse-tile block)
  (define block-items (string-split block "\n"))
  (define id (string-replace (string-replace (car block-items) "Tile " "") ":" ""))
  (define rows (map (lambda (row) (map string (string->list row))) (cdr block-items)))
  (make-tile id rows))

;; a b c
;; d e f
;; g h i
;; ->
;; g d a
;; h e b
;; i f c
(define (rotate rows)
  rows)

(define (flip-x rows)
  (map (lambda (row)
        (foldr (lambda (i res) (cons i res)) row)
         ) rows))

(define (create-all-permutations rows)
  ;; 4 x rotate & flips
  rows)

;; backtracking tile permutations

(check-expect (not (empty? input)) #t)


(define result1 '())

(println "Part 1 result is: ")
(println result1)


(define result2 '())

(println "Part 2 result is: ")
(println result2)

(test)
