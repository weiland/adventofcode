#lang racket

(require test-engine/racket-tests)

(define test-report (list 199 200 208 210 200 207 240 269 260 263))

;; input
(define report (map string->number (file->lines "./input/1.txt")))


(define (increases lst counter)
 (cond
   [(>= 1 (length lst)) counter]
   [(< (first lst) (second lst)) (increases (rest lst) (+ 1 counter))]
   [else (increases (rest lst) counter)]
  )
)

(define (increases-two lst counter)
 (cond
   [(>= 3 (length lst)) counter]
   [(< (+ (first lst) (second lst) (third lst)) (+ (second lst) (third lst) (fourth lst))) (increases-two (rest lst) (+ 1 counter))]
   [else (increases-two (rest lst) counter)]
  )
)

(check-expect (increases test-report 0) 7)
(check-expect (increases-two test-report 0) 5)

;; part one
(println (increases report 0))

;; part two
(println (increases-two report 0))

(test)
