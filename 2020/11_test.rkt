#lang racket

(require test-engine/racket-tests)
;; (require racket/trace)
(require "11.rkt")

(define DAY "11")

(define test-input-list
  (map
    (lambda (line) (map string (string->list line)))
    (string-split "L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL" "\n")))
(define first-round
  (map
    (lambda (line) (map string (string->list line)))
    (string-split "#.##.##.##
#######.##
#.#.#..#..
####.##.##
#.##.##.##
#.#####.##
..#.#.....
##########
#.######.#
#.#####.##" "\n")))

(define expected-test-number 37)

(define input-list
  (map
    (lambda (line) (map string (string->list line)))
    (file->lines (string-append "./input/" DAY ".txt"))))

(check-expect (not (empty? input-list)) #t)

; (check-expect (solve-part-one test-input-list) expected-test-number)
; (check-expect (handle-seat test-input-list 2 0) test-input-list)
(check-expect (handle test-input-list 0 0) first-round)

(print "Part 1 result is: ")
; (println (solve-part-one input-list))


(print "Part 2 result is: ")
(println (solve-part-two))

(test)
