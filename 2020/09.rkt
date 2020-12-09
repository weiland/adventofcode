#lang racket

(require test-engine/racket-tests)

(define DAY "9")

(define test-list '(35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576
))
(define expected-number 127)

(define input (map string->number (file->lines (string-append "./input/" DAY ".txt"))))

(check-expect (not (empty? input)) #t)

(define (check-lists a b result)
  (cond
    [(empty? a) result]
    [(empty? b) (check-lists (rest a) (rest a) result)]
    [(equal? result (+ (first a) (first b))) #t]
    [#true (check-lists a (rest b) result)]))

(check-expect (check-lists '(3 2 1) '(3 2 1) 4) #t)
(check-expect (check-lists '(3 2 4) '(3 2 4) 6) #t)
(check-expect (check-lists '(3 2 5) '(2 5) 7) #t)
(check-expect (check-lists '(3 2 8) '(3 2 8) 6) #t)
(check-expect (check-lists (take test-list 5) (take test-list 5) 40) #t)
(check-expect (check-lists (take test-list 5) (take test-list 5) 62) #t)
(check-expect (check-lists (take test-list 5) (take test-list 5) 65) 65)
(check-expect (check-lists (take test-list 5) (take test-list 5) 127) 127)

(define (get-pair numbers start-position preamble-length)
  (list
    (take (drop numbers start-position) preamble-length)
    (list-ref numbers (+ preamble-length start-position))))

(check-expect (get-pair test-list 0 5) '((35 20 15 25 47) 40))
(check-expect (get-pair test-list 1 5) '((20 15 25 47 40) 62))
(check-expect (get-pair test-list 2 5) '((15 25 47 40 62) 55))
(check-expect (get-pair test-list 3 5) '((25 47 40 62 55) 65))
(check-expect (get-pair test-list 9 5) '((95 102 117 150 182) 127))

(define (check-pair numbers start-position preamble-length)
  (if
    (>= (+ start-position preamble-length) (length numbers)) #f
    (let
      [(pair (get-pair numbers start-position preamble-length))]
      (check-lists (first pair) (rest (first pair)) (second pair)))))

(check-expect (check-pair test-list 0 5) #t)
(check-expect (check-pair test-list 1 5) #t)
(check-expect (check-pair test-list 2 5) #t)
(check-expect (check-pair test-list 3 5) #t)
(check-expect (check-pair test-list 8 5) #t)
(check-expect (check-pair test-list 9 5) 127)
(check-expect (check-pair test-list 10 5) #t)
(check-expect (check-pair test-list 14 5) #t)
(check-expect (check-pair test-list 15 5) #f)

(define (solve numbers start-position preamble-length)
  (let [(result (check-pair numbers start-position preamble-length))]
    (cond
      [(number? result) result]
      [result (solve numbers (+ start-position 1) preamble-length)]
      [else #f])))

(check-expect (solve test-list 0 5) expected-number)


(define result1 (solve input 0 25))
(check-expect result1 (/ 44407155309 23))

(println "Part 1 result is: ")
(println result1)

(define (check-pair-two numbers end-position expected)
  (cond
    [(empty? numbers) (error "list is empty")]
    [(> (first numbers) expected) (error "first number is too big")]
    [(= (first numbers) expected) (raise "first number is equal to expected number")]
    [(> (list-ref numbers end-position) expected) (error (list-ref numbers end-position))]
    [(= (list-ref numbers end-position) expected) (raise "end pos is equal to expected number")]
    [(> (foldr + 0 (take numbers end-position)) expected) (check-pair-two (rest numbers) 1 expected)]
    [(= (foldr + 0 (take numbers end-position)) expected) (+ (apply min (take numbers end-position)) (apply max (take numbers end-position)))]
    [(< (foldr + 0 (take numbers end-position)) expected) (check-pair-two numbers (+ 1 end-position) expected)]
    [else (raise "oh no")]))
    ; [else (check-pair-two numbers (+ 1 end-position) expected)]))

(check-expect (check-pair-two test-list 1 127) 62)

(define result2 (check-pair-two input 1 (/ 44407155309 23)))

(println "Part 2 result is: ")
(println result2)

(check-expect result2 (/ 11292886962 42))

(test)
