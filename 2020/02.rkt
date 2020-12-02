#lang racket

(require test-engine/racket-tests)

(define DAY "2")

(define test-list (list "1-3 a: abcde" "1-3 b: cdefg" "2-9 c: ccccccccc"))

(define input (file->lines "./input/2.txt"))

(check-expect (not (empty? input)) #true)

; (define-struct policy (min max letter string))

(define (split str)
  (string-split str ":" #:trim? #t))

(check-expect (split (first test-list)) (list "1-3 a" " abcde"))

(define (policy lst) (first lst))
(check-expect (policy (split (first test-list))) "1-3 a")


(define (letter str) (last (string-split str)))
(check-expect (letter (policy (split (first test-list)))) "a")

(define (min str) (first (string-split (first (string-split str)) "-")))
(check-expect (min (policy (split (first test-list)))) "1")

(define (max str) (last (string-split (first (string-split str)) "-")))
(check-expect (max (policy (split (first test-list)))) "3")

(define (word lst) (last lst))
(check-expect (word (split (first test-list))) " abcde")


(define (get-policy str) (policy (split str)))
(define (get-word str) (word (split str)))

(check-expect (get-policy (third test-list)) "2-9 c")
(check-expect (get-word (third test-list)) " ccccccccc")

(define (get-min str) (string->number (min (get-policy str))))
(check-expect (get-min (third test-list)) 2)

(define (get-max str) (string->number (max (get-policy str))))
(check-expect (get-max (third test-list)) 9)

(define (get-letter str) (letter (get-policy str)))
(check-expect (get-letter (third test-list)) "c")

(define (letter-occurrence letter word)
  (length (filter
            (lambda (c) (equal? c (first (string->list letter))))
            (string->list word))))

(check-expect (letter-occurrence "a" "fdsa") 1)
(check-expect (letter-occurrence "a" "asdf") 1)
(check-expect (letter-occurrence "a" "baab") 2)
(check-expect (letter-occurrence "a" "aabb") 2)

(define (matches min max occ)
  (and (>= occ min) (<= occ max)))

(check-expect (matches 1 2 1) #t)
(check-expect (matches 1 2 2) #t)
(check-expect (matches 1 2 0) #f)
(check-expect (matches 1 2 3) #f)
(check-expect (matches 1 3 2) #t)

(define (valid-password? str)
  (matches (get-min str) (get-max str) (letter-occurrence (get-letter str) (get-word str))))

(check-expect (valid-password? (first test-list)) #t)
(check-expect (valid-password? (second test-list)) #f)
(check-expect (valid-password? (third test-list)) #t)

(define (how-many-passwords lst) (length (filter valid-password? lst)))

(check-expect (how-many-passwords test-list) 2)

(define result1 (how-many-passwords input))

(println "Part 1 result is: ")
(println result1)

(define (is-letter-at-position? letter position word)
  (equal? (first (string->list letter)) (list-ref (string->list word) position)))
(check-expect (is-letter-at-position? "a" 1 " asdf") #t) ; there is always a space at the begin
(check-expect (is-letter-at-position? "f" 4 " asdf") #t)
(check-expect (is-letter-at-position? "a" 1 (get-word (first test-list))) #t)

(define (valid-password-two? str)
  (xor (is-letter-at-position? (get-letter str) (get-min str) (get-word str))
       (is-letter-at-position? (get-letter str) (get-max str) (get-word str))))

(check-expect (valid-password-two? (first test-list)) #t)
(check-expect (valid-password-two? (second test-list)) #f)
(check-expect (valid-password-two? (third test-list)) #f)

(define (how-many-passwords-two lst) (length (filter valid-password-two? lst)))

(check-expect (how-many-passwords-two test-list) 1)

(define result2 (how-many-passwords-two input))

(println "Part 2 result is: ")
(println result2)

(test)
