#lang racket

(require test-engine/racket-tests)

(define DAY "6")

(define test-list '())
(define expected-number 7)

(define input (file->string (string-append "./input/" DAY ".txt")))

(check-expect (not (empty? input)) #true)

(define test-input "abc

a
b
c

ab
ac

a
a
a
a

b")

(define (get-groups str) (string-split str "\n\n"))

(check-expect (length (get-groups test-input)) 5)

(define (get-answers str)
  (length (remove-duplicates (flatten (map (lambda (s) (map string (string->list s))) (string-split str "\n"))))))

(check-expect (get-answers (first (get-groups test-input))) 3)
(check-expect (get-answers (second (get-groups test-input))) 3)
(check-expect (get-answers (third (get-groups test-input))) 3)
(check-expect (get-answers (fourth (get-groups test-input))) 1)
(check-expect (get-answers (fifth (get-groups test-input))) 1)

(define (get-sum str) (apply + (map get-answers (get-groups str))))


(define result1 (get-sum input))

(println "Part 1 result is: ")
(println result1)

(define (make-groups str)
  ; (map get-answers (get-groups str)))
  (map
    (lambda (group)
      (map
        (lambda (person)
          (map string (string->list person)))
        (string-split group "\n"))) (string-split str "\n\n")))

(define test-group (make-groups test-input))

(define (check choice people)
  (remove-duplicates
      (filter identity (map (lambda (choices) (if (not (not (member choice choices))) choice #f)) people))))

(define (check-num choice people)
  (foldr (lambda (person result)
           (if (equal? 0 result) 0 
               (if (not (not (member choice person))) 1 0))
           ) 1 people))

(define (ga group)
  (cond
    [(empty? group) 0]
    [(empty? (rest group)) (length (flatten group))]
    [else (apply + (map (lambda (choice) (check-num choice (rest group))) (first group)))]))

(define (solve-two groups)
  (apply + (map ga groups))
)

(check-expect (solve-two test-group) 6)

(define result2 (solve-two (make-groups input)))

(println "Part 2 result is: ")
(println result2)

(test)
