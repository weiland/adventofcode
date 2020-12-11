#lang racket

(provide handle handle-seat count-occupied-seats solve-part-one
         is-occupied-seat?
         get-adjacent-seats-two
         solve-part-two)

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
      (<= 4 (count-seats (get-adjacent-seats seats x y) is-occupied-seat?))))

(define (do-seat seats x y)
  (cond
    [(can-be-seated? seats x y) "#"]
    [(can-be-emptied? seats x y) "L"]
    [else (list-ref (list-ref seats y) x)]))

(define (handle-row seats output x y)
  (let [(row (list-ref output y))]
    (list-set row x (do-seat seats x y))))

(define (handle-seat seats output x y)
  (list-set output y (handle-row seats output x y)))

(define (handle seats output x y)
  (cond
    [(>= y (length seats)) output]
    [(>= x (length (first seats))) (handle seats output 0 (+ 1 y))]
    [else (handle seats (handle-seat seats output x y) (+ 1 x) y)]
  ))

(define (count-occupied-seats rows)
  (length
    (flatten
      (map
        (lambda (row)
            (filter is-occupied-seat? row)) rows))))

(define (walk rows)
  (let [(first-attempt (handle rows rows 0 0))]
    (let [(second-attempt (handle first-attempt first-attempt 0 0))]
      (if (equal? first-attempt second-attempt) first-attempt (walk second-attempt)))))

(define (get-adjacent-seats-level seats x y level)
  (list
    ;; left col (including diag)
    (get-seat seats (- x level) (- y level))
    (get-seat seats (- x level) y)
    (get-seat seats (- x level) (+ y level))

    ;; bottom and top seats
    (get-seat seats x (- y level))
    (get-seat seats x (+ y level))

    ;; right col (including diag)
    (get-seat seats (+ x level) (- y level))
    (get-seat seats (+ x level) y)
    (get-seat seats (+ x level) (+ y level))))

(define (get-adjacent-seats-two seats x y level max-level pred)
  (cond
    [(< max-level level) empty]
    [else (filter pred (append
            (get-adjacent-seats-level seats x y level)
            (get-adjacent-seats-two seats x y (+ 1 level) max-level pred)))]))

(define (solve-part-one rows)
  (count-occupied-seats (walk rows)))

(define (solve-part-two)
  2)
