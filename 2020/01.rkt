#lang racket

(require test-engine/racket-tests)

(define DAY "1")

(define test-list (list 1721 979 366 299 675 1456))

(define input (map string->number (file->lines "./input/1.txt")))

(check-expect (not (empty? input)) #true)
(check-expect (length input) 200)
(check-expect (first input) 1974)

; (define sorted-input (sort input <))


(define (check-lists a b result) 
  (cond 
    [(empty? a) #f]
    [(empty? b) (check-lists (rest a) (rest a) result)]
    [(equal? result (+ (first a) (first b))) (* (first a) (first b))]
    [#true (check-lists a (rest b) result)]
  )
)

; part two
(define (check-lists-two a b c result) 
  (cond 
    [(empty? a) #f]
    [(empty? b) (check-lists-two (rest a) (rest a) (rest a) result)]
    [(or (>= (+ (first a) (first b)) 2020) (empty? c)) (check-lists-two a (rest b) (rest b) result)]
    [(equal? result (+ (first a) (first b) (first c))) (* (first a) (first b) (first c))]
    [#true (check-lists-two a b (rest c) result)]
  )
)

(check-expect (check-lists '() '() 2020) #f)
(check-expect (check-lists '(1) '() 2020) #f)
(check-expect (check-lists '(1) '(1) 2020) #f)
(check-expect (check-lists test-list test-list 2020) (* 1721 299))

(define (check lst result)
  (check-lists lst lst result)
)
(check-expect (check '() 2020) #f)
(check-expect (check '(1 2 3) 2020) #f)
(check-expect (check '(1 2 3) 3) 2)
(check-expect (check '(1 2 3) 5) 6)
(check-expect (check '(1 2 3 4) 5) 4)
(check-expect (check '(1 2 3 4) 7) 12)
(check-expect (check test-list 2020) (* 1721 299))

(println "The result is: ")
(println (check input 2020))
(println (check-lists-two input input input 2020))
(println "fin")

(test)
