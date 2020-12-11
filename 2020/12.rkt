#lang racket

(require test-engine/racket-tests)
;; (require racket/trace)

(define DAY "12")

(define (transform-instruction str) (list (substring str 0 1) (string->number (substring str 1))))

(define test-instructions (map transform-instruction '("F10" "N3" "F7" "R90" "F11")))

(define instructions (map transform-instruction (file->lines (string-append "./input/" DAY ".txt"))))

(check-expect (not (empty? instructions)) #t)

(define (parse-instruction instruction direction)
  (let [(action (first instruction)) (value (second instruction))]
    (cond
      [(or (equal? action "N") (and (equal? action "F") (equal? direction 0))) (list value 0 direction)]
      [(or (equal? action "S") (and (equal? action "F") (equal? direction 180))) (list (- 0 value) 0 direction)]
      [(or (equal? action "E") (and (equal? action "F") (equal? direction 90))) (list 0 value direction)]
      [(or (equal? action "W") (and (equal? action "F") (equal? direction 270))) (list 0 (- 0 value) direction)]
      [(equal? action "L") (list 0 0 (if (negative? (- direction value)) (+ 360 (- direction value)) (- direction value)))]
      [(equal? action "R") (list 0 0 (if (>= (+ value direction) 360) (- (+ value direction) 360) (+ direction value)))]
      [else (raise "oh no!")])))

(check-expect (parse-instruction (first test-instructions) 90) (list 0 10 90))

(define (parse-instructions instructions)
  (foldl (lambda (raw-instruction previous-instruction)
           (let [(instruction (parse-instruction raw-instruction (third previous-instruction)))]
            (list
              (+ (first instruction) (first previous-instruction))
              (+ (second instruction) (second previous-instruction))
              (third instruction)
            )
           )
           ) '(0 0 90) instructions))

(define (solve-part-one instructions)
  (let
    ((result (parse-instructions instructions)))
    (+ (abs (first result)) (abs (second result)))))

(check-expect (solve-part-one test-instructions) (+ 17 8))


(define result1 (solve-part-one instructions))

(println "Part 1 result is: ")
(println result1)


(define result2 '())

(println "Part 2 result is: ")
(println result2)

(test)
