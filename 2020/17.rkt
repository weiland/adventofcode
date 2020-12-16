#lang racket
(require test-engine/racket-tests)

(define DAY "17")
(define (parse-input lines)
  (list (map (lambda (str)
               (map string (string->list str))) lines)))

(define input (parse-input (file->lines (string-append "./input/" DAY ".txt"))))
(check-expect (not (empty? input)) #t)

(define test-input (parse-input (string-split ".#. ..# ###" " ")))
(check-expect (length test-input) 1)
(check-expect (length (car test-input)) 3)
(check-expect (length (car (car test-input))) 3)

(define MAX_CYCLES 6)
(define ACTIVE "#")
(define INACTIVE ".")

(define (is-active cube) (equal? cube ACTIVE))
(define (is-inactive cube) (equal? cube INACTIVE))

(define (get-all-neighbours-positions x y z)
  (filter-not
    (lambda (i) (equal? i (list x y z)))
    (apply
      append
      (build-list 3 (lambda (x-num)
                      (apply
                        append
                        (build-list 3 (lambda (y-num)
                                        (build-list 3 (lambda (z-num)
                                                        (list
                                                          (+ x-num (sub1 x))
                                                          (+ y-num (sub1 y))
                                                          (+ z-num (sub1 z)))))))))))))

(define test-neighbours (get-all-neighbours-positions 1 2 3))
test-neighbours
(check-expect (length test-neighbours) 26)
(check-expect (member '(1 2 3) test-neighbours) #f)
(check-expect (car test-neighbours) '(0 1 2))
(check-expect (second test-neighbours) '(0 1 3))
(check-expect (third test-neighbours) '(0 1 4))
(check-expect (fourth test-neighbours) '(0 2 2))
(check-expect (last test-neighbours) '(2 3 4))

;; default state: inactive (.)
;; x, y, z = dim(3)
;; - 26 neighbours (3 x 3 x 3 - 1)

;; obtain item from list (indexes must be valid)
(define (iterate-x lst x y z)
  (list-ref
    (list-ref
      (list-ref lst z) y) x))

;; return item or "." (inactive item if out of bounds)
(define (get-item lst x y z)
  (if
    (and
      (>= z 0) (<  z (length lst))
      (>= y 0) (<  y (length (car lst)))
      (>= x 0) (<  x (length (car (car lst)))))
    (iterate-x lst x y z)
    INACTIVE
    ))

;; build list of all possible indexes
(define (build-indexes lst)
  (apply append (map (lambda (z)
         (apply append (map (lambda (y)
                (map (lambda (x)
                       (list x y z)
                       ) (build-list (length (car (car lst))) values))
                ) (build-list (length (car lst)) values)))
         ) (build-list (length lst) values))))

(define (iterate-z lst cycle z)
  (define x-y (list-ref lst z))
  (define behind
      (if (>= (sub1 z) 0)
          '()
          #f ;; only inactive ones
    ))
  (define before
      (if (< (add1 z) (length lst))
          '()
          #f ;; only inactive ones
    ))
  ; (map x-y (lambda (xs)
  ;            (define item (get-item x y z))
  ;            (cond
  ;              [(is)]
  ;            )
  ; ))
  #f
  )

(define (solve-part-one lst cycle)
  (define zts (length lst))
  (define ys (length (car lst)))
  (define xs (length (car (car lst))))
  (map lst (lambda (x-y) x-y))
  )


(define result1 '())

(println "Part 1 result is: ")
result1


(define result2 '())

(println "Part 2 result is: ")
result2

(test)
