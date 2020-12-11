#lang racket

(provide handle handle-seat solve-part-one solve-part-two)

(define (get-seat seats x y)
  (cond
    ;; edge cases
    [(or (< x 0) (< y 0)) #f]
    [(or (>= x (length (first seats))) (>= y (length seats))) #f]

    ;; default case (safe)
    [else (list-ref (list-ref seats y) x)]))

(define (get-adjacent-seats seats x y)
  (list
    ;; left col (including diag)
    (get-seat seats (- x 1) (- y 1))
    (get-seat seats (- x 1) y)
    (get-seat seats (- x 1) (+ y 1))

    ;; bottom and top seats
    (get-seat seats x (- y 1))
    (get-seat seats x (+ y 1))

    ;; right col (including diag)
    (get-seat seats (+ x 1) (- y 1))
    (get-seat seats (+ x 1) y)
    (get-seat seats (+ x 1) (+ y 1))))

(define (is-free-seat? seat)
  (equal? seat "L"))

(define (is-occupied-seat? seat)
  (equal? seat "#"))

(define (count-seats seats count-method)
  (foldr
    (lambda (seat counter)
      (if (count-method seat) (+ 1 counter) counter)) 0 seats))

(define (can-be-seated? seats x y)
  (and
      (is-free-seat? (get-seat seats x y))
      (equal? 0 (count-seats (get-adjacent-seats seats x y) is-occupied-seat?))))

(define (can-be-emptied? seats x y)
  (and
      (is-occupied-seat? (get-seat seats x y))
      (equal? 0 (count-seats (get-adjacent-seats seats x y) is-occupied-seat?))))

(define (do-seat seats x y)
  (cond
    [(can-be-seated? seats x y) "#"]
    [(can-be-emptied? seats x y) "L"]
    [else (list-ref (list-ref seats y) x)]))

(define (handle-row seats x y)
  (let [(row (list-ref seats y))]
    (list-set row x (do-seat seats x y))
    ))

(define (handle-seat seats x y)
  (list-set seats y (handle-row seats x y)))

(define (handle seats x y)
  (cond
    [(>= y (length seats)) seats]
    [(>= x (length (first seats))) (handle seats 0 (+ 1 y))]
    [else (handle (handle-seat seats x y) (+ 1 x) y)]
  ))

(define (solve-part-one rows)
  rows)

(define (solve-part-two)
  2)
