#lang racket

(require test-engine/racket-tests)

(define test-commands (list '("forward" "5")
'("down" "5")
'("forward" "8")
'("up" "3")
'("down" "8")
'("forward" "2")))

;; input
(define commands (map (lambda (line) (string-split line " ")) (file->lines "./input/2.txt")))


(define (move direction num)
  (cond
    [(equal? direction "forward") (list num 0)]
    [(equal? direction "up") (list 0 (- 0 num))]
    [(equal? direction "down") (list 0 num)]
    [else (list 0 0)]
    )
  )

(define (move-aim direction num position depth aim)
  (cond
    [(equal? direction "forward") (list (+ num position) (+ depth (* aim num)) aim)]
    [(equal? direction "up") (list position depth (- aim num))]
    [(equal? direction "down") (list position depth (+ aim num))]
    [else (list position depth aim)]
    )
  )

(define (get-position lst)
  (cond
    [(empty? lst) '(0 0)]
    [else (map + (get-position (rest lst)) (move (first (first lst)) (string->number (second (first lst)))))]
    )
  )

(define (get-position-aim lst position depth aim)
  (cond
    [(empty? lst) (list position depth aim)]
    [(equal? (first (first lst)) "forward") (get-position-aim (rest lst) (+ (string->number (second (first lst))) position) (+ depth (* aim (string->number (second (first lst))))) aim)]
    [(equal? (first (first lst)) "up") (get-position-aim (rest lst) position depth (- aim (string->number (second (first lst)))))]
    [(equal? (first (first lst)) "down") (get-position-aim (rest lst) position depth (+ aim (string->number (second (first lst)))))]
    )
  )

(define (part-one lst)
  (foldr * 1 (get-position lst))
  )

(define (part-two lst)
  (foldr * 1 (reverse (cdr (reverse (get-position-aim lst 0 0 0)))))
  )

(check-expect (map + '(2 4) (list 8 16)) '(10 20))

(check-expect (part-one test-commands) 150)
(check-expect (part-two test-commands) 900)

;; part one
(println (part-one commands))

;; part two
(println (part-two commands))

(test)
