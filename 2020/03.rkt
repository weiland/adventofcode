#lang racket

(require racket/date)
(require test-engine/racket-tests)

; (define DAY (number->string (date-day (current-date))))
(define DAY "3")

(define test-list '("..##.........##.........##.........##.........##.........##......."
"#..##...#..#...#...#..#...#...#..#...#...#..#...#...#..#...#...#.."
".#....X..#..#....#..#..#....#..#..#....#..#..#....#..#..#....#..#."
"..#.#...###..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#"
".#...##..#..X...##..#..#...##..#..#...##..#..#...##..#..#...##..#."
"..#.##.......#.X#.......#.##.......#.##.......#.##.......#.##....."
".#.#.#....#.#.#.#.#..#.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#"
".#........#.#........#.#........#.#........#.#........#.#........#"
"#.##...#...#.##...#...#.##...#...#.##...#...#.##...#...#.##...#..."
"#...##....##...##....##...##....##...##....##...##....##...##....#"
".#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#"))
(define test-list-expected '("..##.........##.........##.........##.........##.........##......."
"#..O#...#..#...#...#..#...#...#..#...#...#..#...#...#..#...#...#.."
".#....X..#..#....#..#..#....#..#..#....#..#..#....#..#..#....#..#."
"..#.#...#O#..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#"
".#...##..#..X...##..#..#...##..#..#...##..#..#...##..#..#...##..#."
"..#.##.......#.X#.......#.##.......#.##.......#.##.......#.##....."
".#.#.#....#.#.#.#.O..#.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#"
".#........#.#........X.#........#.#........#.#........#.#........#"
"#.##...#...#.##...#...#.X#...#...#.##...#...#.##...#...#.##...#..."
"#...##....##...##....##...#X....##...##....##...##....##...##....#"
".#..#...#.#.#..#...#.#.#..#...X.#.#..#...#.#.#..#...#.#.#..#...#.#"))
(define test-row (first test-list))
(define expected-number 7)
(define test-MAX_X (length (string->list test-row)))

(define input (file->lines (string-append "./input/" DAY ".txt")))

(check-expect (not (empty? input)) #t)

(define MAX_X (length (string->list (first input))))

(define (handle-row row xPos trees)
  (cond
    [(>= xPos MAX_X) (handle-row row (- xPos MAX_X) trees)]
    [(equal? #\# (list-ref (string->list row) xPos)) (+ 1 trees)]
    [#t trees]
    ))
(check-expect (handle-row test-row 0 0) 0)
(check-expect (handle-row test-row 2 0) 1)


(define (move rows xPos right trees) 
  (cond
    [(empty? rows) trees]
    [#t (move (rest rows) (+ right xPos) right (handle-row (first rows) xPos trees))]
    ))
(check-expect (move '() 0 3 5) 5)
(check-expect (move test-list 0 3 0) expected-number)
(check-expect (move (list test-row) 0 3 0) 0)
(check-expect (move (list (second test-list)) 0 3 0) 1)


(define (move-two rows xPos right trees) 
  (cond
    [(empty? rows) trees]
    [(empty? (rest rows)) trees]
    [#t (move-two (rest (rest rows)) (+ right xPos) right (handle-row (first rows) xPos trees))]
    ))


(define result1 (move input 0 3 0))

(check-expect result1 205)
(println "Part 1 result is: ")
(println result1)


(define result2
  (*
    (move input 0 1 0)
    (move input 0 3 0)
    (move input 0 5 0)
    (move input 0 7 0)
    (move-two input 0 1 0)
    ))

(println "Part 2 result is: ")
(println result2)

(println "Fin")

(test)
