#lang racket

(require test-engine/racket-tests)
;; (require racket/trace)

(define DAY "10")

(define test-list (sort '(0 28 33 18 42 31 14 46 20 48 47 24 23 49 45 19 38 39
                          11 1 32 25 35 8 17 7 9 4 2 34 10 3 52) <))
(define expected-number (* 22 10))

(define input (cons 0
                (map
                  string->number (file->lines
                                  (string-append "./input/" DAY ".txt")))))
(define adapters (sort (cons (+ 3 (apply max input)) input) <))

(check-expect (not (empty? adapters)) #t)

(define (step-counter numbers steps)
  (cond
    [(or (empty? numbers) (empty? (rest numbers))) (reverse steps)]
    [else (step-counter
            (rest numbers)
            (cons (- (second numbers) (first numbers)) steps))]))

(define (get-ones steps)
  (length (filter (lambda (step) (equal? 1 step)) steps)))

(define (get-threes steps)
  (length (filter (lambda (step) (equal? 3 step)) steps)))

(check-expect (step-counter '(1) '(42)) '(42))
(check-expect (step-counter '() '(42)) '(42))
(check-expect (step-counter '(1 2 4) '()) '(1 2))

(check-expect (get-ones (step-counter test-list '())) 22)
(check-expect (get-threes (step-counter test-list '())) 10)

(check-expect (*
                (get-ones (step-counter test-list '()))
                (get-threes (step-counter test-list '())))
            expected-number)

(define result1 (*
                (get-ones (step-counter adapters '()))
                (get-threes (step-counter adapters '()))))

(println "Part 1 result is: ")
(println result1)
(check-expect result1 (/ 53889 23))

(define (two lst runs prods)
  (cond
    [(or (empty? lst) (empty? (rest lst))) prods]
    [(equal? 1 (- (second lst) (first lst))) (two (rest lst) (+ 1 runs) prods)]
    [(equal? runs 3) (two (rest lst) 1 (* 2 prods))]
    [(equal? runs 4) (two (rest lst) 1 (* 4 prods))]
    [(equal? runs 5) (two (rest lst) 1 (* 7 prods))]
    [else (two (rest lst) 1 prods)]))


(check-expect (two test-list 1 1) 19208)

(define result2 (two adapters 1 1))


(println "Part 2 result is: ")
(println result2)
(check-expect result2 (* (* 3947645370368 4)2))

(test)
