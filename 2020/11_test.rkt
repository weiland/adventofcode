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
(define second-round
  (map
    (lambda (line) (map string (string->list line)))
    (string-split "#.LL.L#.##
#LLLLLL.L#
L.L.L..L..
#LLL.LL.L#
#.LL.LL.LL
#.LLLL#.##
..L.L.....
#LLLLLLLL#
#.LLLLLL.L
#.#LLLL.##" "\n")))
(define third-round
  (map
    (lambda (line) (map string (string->list line)))
    (string-split "#.##.L#.##
#L###LL.L#
L.#.#..#..
#L##.##.L#
#.##.LL.LL
#.###L#.##
..#.#.....
#L######L#
#.LL###L.L
#.#L###.##" "\n")))
(define fifth-round
  (map
    (lambda (line) (map string (string->list line)))
    (string-split "#.#L.L#.##
#LLL#LL.L#
L.#.L..#..
#L##.##.L#
#.#L.LL.LL
#.#L#L#.##
..L.L.....
#L#L##L#L#
#.LLLLLL.L
#.#L#L#.##" "\n")))

(define expected-test-number 37)

(define input-list
  (map
    (lambda (line) (map string (string->list line)))
    (file->lines (string-append "./input/" DAY ".txt"))))

(check-expect (not (empty? input-list)) #t)

; (check-expect (solve-part-one test-input-list) expected-test-number)
; (check-expect (handle-seat test-input-list 2 0) test-input-list)
(define fr (handle test-input-list test-input-list 0 0))
(check-expect fr first-round)
(define sr (handle fr fr 0 0))
(check-expect sr second-round)
(define tr (handle sr sr 0 0))
(check-expect tr third-round)
(define for (handle tr tr 0 0))
(define fir (handle for for 0 0))
(define sir (handle fir fir 0 0))

(check-expect fir fifth-round)
(check-expect sir fifth-round)

; (check-expect (solve-part-one test-input-list) fifth-round)
(check-expect (count-occupied-seats fir) expected-test-number)
(check-expect (count-occupied-seats fifth-round) expected-test-number)
(check-expect (solve-part-one test-input-list) expected-test-number)

(print "Part 1 result is: ")
; (println (solve-part-one input-list))

(define test1
  (map
    (lambda (line) (map string (string->list line)))
    (string-split ".......#.
...#.....
.#.......
.........
..#L....#
....#....
.........
#........
...#....." "\n")))
(define test2
  (map
    (lambda (line) (map string (string->list line)))
    (string-split ".##.##.
#.#.#.#
##...##
...L...
##...##
#.#.#.#
.##.##." "\n")))

(check-expect (length (get-adjacent-seats-two test1 3 4 1 (length test1) is-occupied-seat?)) 8)
(check-expect (length (get-adjacent-seats-two test1 3 3 1 (length test2) is-occupied-seat?)) 0)


(print "Part 2 result is: ")
; (println (solve-part-two))

(test)
