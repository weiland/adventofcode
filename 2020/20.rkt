#lang racket

(require test-engine/racket-tests)
;; (require racket/trace)

(define DAY "20")
(define input (string-split (file->string (string-append "./input/" DAY ".txt")) "\n\n"))

;; use only all four sides

(define-struct tile (id north east south west))

(define (parse-tile block)
  (define block-items (string-split block "\n"))
  (define id (string-replace (string-replace (car block-items) "Tile " "") ":" ""))
  (define rows (map (lambda (row) (map string (string->list row))) (cdr block-items)))
  (make-tile id (car rows) (map last rows) (last rows) (map car rows)))

(define (rotate tile)
  (make tile
        (tile-id tile)
        (tile-west tile)
        (tile-north tile)
        (tile-south tile)
        (tile-east tile)))

;; flip = reverse list

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
