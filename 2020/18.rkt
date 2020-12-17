#lang racket

(require test-engine/racket-tests)

(define DAY "18")

(define test-list (list 1 + 2 * 3 + 4 * 5 + 6))

(define (parse-term str)
  (read (open-input-string str)))
  ; (if
  ;   (string->number str)
  ;   (string->number str)
  ;   str
  ;   ))
  ; (cond
  ;   [(equal? str "+") +]
  ;   [(equal? str "*") *]
  ;   [(or (equal? str "(") (equal? str ")")) str]
  ;   [else (string->number str)]))

(define input (map (lambda (term)
                     (parse-term term))
                   (file->lines (string-append "./input/" DAY ".txt"))))
(check-expect (not (empty? input)) #t)


(define (execute operation operand1 operand2)
  (define op (cond
               [(equal? operation "+") +]
               [(equal? operation "*") *]
               [else (error "invalid operation")]
               ))
  (op operand1 operand2))

(define (is-operator str)
  (or (equal? str *) (equal? str +)))

(define (get-operator operation)
  (cond
    [(equal? operation "+") +]
    [(equal? operation "*") *]
    [(string->number operation) (error "number not expedted")]
    [else (error "invalid operation")]))

(define (get-number num)
  (string->number num)
  )

;; look-ahead = 1 to 2

(define (calc-term lst)
  (cond
    [(empty? lst) (error "list empty")]
    [(or (empty? (cdr lst)) (equal? (car (cdr lst)) ")")) (car lst)]
    [(equal? (car lst) "(") "new nesting"]
    [(equal? (car lst) ")") (error "`)` was not expected")]
    [else
      (let [(num (string->number (car lst)))]
        #f
    )]
    )
  )

(check-error (calc-term empty) "list empty")
(check-expect (calc-term '(42)) 42)
; (check-expect (calc-term '(42 + 42)) 42)

(define (parse1 term)
  (cond
    [(empty? term) (error "term is empty")]
    [(or (empty? (cdr term)) (equal? (car (cdr term)) ")")) (car term)]
    [(equal? (car term) "(") (parse1 (cdr term))]
    [(equal? (car term) ")") (parse1 (cdr term))]
    [(number? (car term))
     (cond
       [(not (is-operator (car (cdr term)))) (error "operator expected")]
       [(number? (car (cdr (cdr term)))) ((car (cdr term)) (car term) (car (cdr (cdr term))))]
       [else (parse1 (cdr (cdr term)))]
                            )]
    [else (error "not supposed to happen")]
    ))

      ; [(empty? term) (error "term is empty")]
      ; [(empty? (cdr term)) (error "no test")]
      ; [(equal? (car (cdr term)) ")") (error "next is )")]
      ; [(equal? (car term) "(") (error "is (")]
      ; [(equal? (car term) ")") (error "is )")]
      ; [(< (length term) 3) (error "term is too short")]

(define (parse2 or1 term)
  (cond
    [(equal? or1 "(") (parse2 (car term) (cdr term)) or1]
    )
  (define operator (car term))
  (define operand1 (if (equal? or1 "(") (parse2 (car term) (cdr term)) or1))
  (define operand2 (if (equal? (car (cdr term)) "(") (parse2 (car term) (cdr term)) or1))
  ; (define operand2 (car (cdr term)))
  (define rest-term (cdr (cdr term)))
  (define expr
    (cond
      [(not (is-operator operator)) (error "invalid operator")]
      [(equal? operand1 "(") (parse2 (car (cdr term)) (cdr (cdr term)))]
      [(equal? operand2 "(") (parse2 rest)]
      [(and (number? operand1) (number? operand2)) (operator operand1 operand2)]
      [else (error "invalid operands else")]
      ))
  expr
  )

; (check-expect (parse2 4 (list + 8)) 12)
; (check-expect (parse2 4 (list + 8 * 2)) 24)
; (check-expect (parse2 1 (list + 2 * 3 + 4 * 5 + 6)) 71)

(define (parse-single term)
  (define result ((car (cdr term)) (car term) (car (cdr (cdr term)))))
  (if (empty? (cdr (cdr (cdr term))))
      result
      (parse-single (cons result (cdr (cdr (cdr term)))))))

; (check-error (parse empty) "term is empty")
(check-expect (parse-single (list 4 + 8)) 12)
(check-expect (parse-single (list 4 + 8 * 2)) 24)
(check-expect (parse-single (list 1 + 2 * 3 + 4 * 5 + 6)) 71)

(define (parse-multi term)
  (cond
    [(empty? term) empty]
    [(equal? (car term) "(") (list (parse-multi (cdr term)))]
    [(equal? (car term) ")") (parse-multi (cdr term))]
    [else (cons (car term) (parse-multi (cdr term)))]
    )
  )

(check-expect (parse-multi (list 4 '+ 8 '+ "(" 5 '+ 9 ")")) (list 4 '+ 8 '+ (list 5 '+ 9)))
(check-expect (parse-multi (list 4 '+ "(" 5 '+ 9 ")")) (list 4 '+ (list 5 '+ 9)))
; (check-expect (parse-multi (list 4 '+ "(" 5 '+ "(" 8 '+ 9 ")" '+ 3 ")")) (list 4 '+ (list 5 '+ (list 8 '+ 9) '+ 3)))
; (check-expect (parse-multi (list "(" 7 '+ 2 ")" '+ "(" 5 '+ "(" 8 '+ 9 ")" '+ 3 ")")) (list (list 7 '+ 2) '+ (list 5 '+ (list 8 '+ 9) '+ 3)))

(check-expect (equal? (car (list + 8)) "(") #f)
(check-expect (equal? (car (list + 8)) ")") #f)
(check-expect (list 4 '+ 8) (list 4 '+ 8))
(check-expect (parse-multi (list 4 '+ 8)) (list 4 '+ 8))
(check-expect (parse-multi (list 4 '+ 8)) (list 4 '+ 8))

(define result1 '())

(println "Part 1 result is: ")
(println result1)


(define result2 '())

(println "Part 2 result is: ")
(println result2)

(test)
