#lang racket

(require test-engine/racket-tests)
;; (require racket/trace)

(define DAY "14")

(define (dups row results)
  (define key (car (string-split row "] = ")))
  (define lst (map (lambda (item) (car (string-split item "] = "))) results))
  (if (member key lst)
      results
      (cons row results)))

(define raw-input (file->lines (string-append "./input/" DAY ".txt")))
(define short-input (map (lambda (row)
                           (car (string-split row "] = ")))
                         raw-input))

;; only one duplicate (third times)
(define duplicate (check-duplicates short-input))
(define to-remove (reverse (cdr (reverse (map (lambda (i) (list-ref raw-input i)) (indexes-of short-input duplicate))))))

(define clean-input (remove (second to-remove) (remove (first to-remove) raw-input)))

(define test-list '())
(define expected-number (+ 101 64))

;; helper: decimal to binary (numbr) -> string
(define (decimal->binary n)
  (if (> 2 n) (number->string n)
              (string-append (decimal->binary (quotient n 2))
                             (number->string (remainder n 2)))))
;; ok, we can use (format "~b" num)

(define (parse-input row lst)
  (if (string-contains? row "mask")
      (cons empty
            (list-set lst 0 (cons (string-replace row "mask = " "")
                                  (first lst))))
      (list-set lst 0 (cons (string-split (string-replace (string-replace row "mem[" "") "]" "") " = ")
                            (first lst)))))

(define input (cdr (foldr parse-input (list empty) clean-input)))
(check-expect (not (empty? input)) #t)
(check-expect (length input) 100)


;; (string string) -> decimal number
(define (get-value raw-mask raw-value)
  (define mask (map string (string->list raw-mask)))
  (define value (append
                  (build-list (- 36 (string-length raw-value)) (lambda (n) "0"))
                  (map string (string->list raw-value))))
  (string->number (string-join (map (lambda (m v) (cond
                       [(equal? m "X") v]
                       [(equal? m "0") "0"]
                       [(equal? m "1") "1"]
                       [else (error "invalid mask value")]
                       )) mask value) "") 2))
(check-expect (get-value "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X" "1011") 73)
(check-expect (get-value "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X" "1100101") 101)
(check-expect (get-value "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X" "1000000") 64)

(define (handle-block block)
  (define mask (car block))
  (define inputs (cdr block))
  (map (lambda (value) (get-value mask (format "~b" (string->number (second value))))) inputs))
  ; (index-of inputs (assoc "49559" inputs)))
(check-expect (handle-block (first input)) (map (lambda (i) (first i)) (cdr (first input))))
(check-expect (handle-block (second input)) (map (lambda (i) (first i)) (cdr (second input))))
(check-expect (handle-block (last input)) (map (lambda (i) (first i)) (cdr (last input))))

(define (solve-part-one inpt)
  (apply + (flatten (map handle-block input))))

;; 7477696999511

(define result1 (solve-part-one input))

(println "Part 1 result is: ")
(println result1)


(define result2 '())

(println "Part 2 result is: ")
(println result2)

(test)
