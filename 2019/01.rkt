#lang racket

(require test-engine/racket-tests)

(define (mass->fuel mass)
  (- (floor (/ mass 3)) 2)
)

(define (modules->fuelsum modules) 
  (foldl 
    (lambda (mass result)
      (+ (mass->fuel mass) result)
    )
    0
    (map string->number modules)
  )
)

(define (modules->fuelsumtotal modules) 
  (foldl 
    (lambda (mass result)
      (+ (modules->totalfuel mass) result)
    )
    0
    (map string->number modules)
  )
)

(define (modules->totalfuel mass)
  (mass->totalfuel (mass->fuel mass) 0)
)

(define (mass->totalfuel mass totalfuel)
  (cond
    [(<= mass 0 totalfuel) totalfuel]
    [else (mass->totalfuel (mass->fuel mass) (+ mass totalfuel))]
  )
)

(check-expect (mass->fuel -2) -3)
(check-expect (mass->fuel -1) -3)
(check-expect (mass->fuel 0) -2)
(check-expect (mass->fuel 1) -2)
(check-expect (mass->fuel 5) -1)
(check-expect (mass->fuel 6) 0)
(check-expect (mass->fuel 9) 1)
(check-expect (mass->fuel 10) 1)
(check-expect (mass->fuel 12) 2)
(check-expect (mass->fuel 14) 2)
(check-expect (mass->fuel 1969) 654)
(check-expect (mass->fuel 100756) 33583)


(check-expect (modules->totalfuel 14) 2)
(check-expect (modules->totalfuel 1969) 966)
(check-expect (modules->totalfuel 100756) 50346)


(check-expect (modules->fuelsum (list "9" "10" "12")) (+ (mass->fuel 9) (mass->fuel 10) (mass->fuel 12)))


(define input (file->lines "./01input.txt"))
(check-expect (not (empty? input)) #true)

; stateful tests (verification)
(check-expect (length input) 100)
(check-expect (first input) "95249")
(check-expect (last input) "93518")

; should be: 3331523
(print "The result is: ")
(println (modules->fuelsumtotal input))


(test)
