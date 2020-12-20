#lang racket

(require test-engine/racket-tests)

(define DAY "8")

(define test-list (map (lambda (line) (string-split line " ")) (string-split
"nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6" "\n")))
(define expected-number 5)

(define input
  (map (lambda (line) (string-split line " ")) (file->lines (string-append "./input/" DAY ".txt"))))

(check-expect (not (empty? input)) #t)

(define (is-acc? ins)
  (equal? "acc" (first ins)))

(define (is-jmp? ins)
  (equal? "jmp" (first ins)))

(define (is-nop? ins)
  (equal? "nop" (first ins)))

(define (parse instructions pos acc past)
  (let [(ins (list-ref instructions pos))]
    (cond
      ; [(empty? pos) acc]
      ;; end reached
      [(>= pos (length instructions)) acc]
      ;; if instruction has already run
      [(not (not (member pos past))) acc]
      [(is-acc? ins) (parse instructions (+ 1 pos) (+ (string->number (second ins)) acc) (cons pos past))]
      [(is-jmp? ins) (parse instructions (+ (string->number (second ins)) pos) acc (cons pos past))]
      [(is-nop? ins) (parse instructions (+ 1 pos) acc (cons pos past))]
      [else #f]
      )))

(check-expect (parse test-list 0 0 '()) expected-number)

(define result1 (parse input 0 0 '()))
(check-expect result1 (/ 25001 23))

(println "Part 1 result is: ")
(println result1)

(define (update-list lst)
  (map (lambda (row)
         (let [(str (first row))]
           (cond
             [(equal? str "jmp") "nop"]
             [(equal? str "nop") "jmp"]
             [else #f])
           )) lst))

(println (update-list test-list))
(println (filter identity (update-list test-list)))


(define result2 '())

(println "Part 2 result is: ")
(println result2)

(test)
