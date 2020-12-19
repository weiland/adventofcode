#lang racket

(require test-engine/racket-tests)

(define DAY "19")

;; input is a BNF in CNF S = rule 0

;; and CYK algorithm might help

;; assumptions: only two nonterminals (a and b)
;; NT are single
;; only one | per line

(define (is-terminal? str)
  (and (string-prefix? str "\"") (string-suffix? str "\"")))

; (define (parse-rule str)
;   (define pair (string-split str ": "))
;   (define rule (car pair))
;   (define value (second pair))
;   (list rule
;     (cond
;       [(is-terminal? value) (string-replace value "\"" "")]
;       [else (map (lambda (s) (string-split s " ")) (string-split value "|"))])))

(define (append-to-ht ht key value)
  (if (hash-has-key? ht key)
      (hash-set ht key (append value (hash-ref ht key)))
      (hash-set ht key value))
  )

(define input (string-split (file->string (string-append "./input/" DAY ".txt")) "\n\n"))
(define (handle-rule str ht)
  (define pair (string-split str ": "))
  (define rule (list (car pair)))
  (define terminal (second pair))
  (define productions (string-split terminal " | "))
  (cond
    [(is-terminal? terminal) (hash-set ht (string-replace terminal "\"" "") rule)]
    [(= (length productions) 2) (append-to-ht
                                  (append-to-ht ht (second productions) rule)
                                  (car productions) rule)]
    [else (append-to-ht ht (car productions) rule)]))
(define ht (foldl handle-rule (hash) (string-split (car input) "\n")))
(define words (string-split (second input) "\n"))
(check-expect (length input) 2)
; (check-expect (length rules) 132)
(check-expect (length words) 371)
(check-expect (hash-count ht) 181)

(check-expect (hash-ref ht "a") '("20"))
(check-expect (hash-ref ht "b") '("91"))
(check-expect (hash-ref ht "20 20") '("84" "44" "109" "102" "89" "114"))

(define test-words (map (lambda (w) (map string (string->list w))) (list "ababbb" "bababa" "abbbab" "aaabbb" "aaaabbb")))
(define test-ht
  (foldl handle-rule (hash) (list"0: 4 1 5" "1: 2 3 | 3 2" "2: 4 4 | 5 5" "3: 4 5 | 5 4" "4: \"a\"" "5: \"b\"")))

(hash->list test-ht)

(define (make-level lst level)
  (cond
    [(empty? lst) empty]
    [(>= (length lst) level) (append (flatten (take lst level)) (make-level (drop lst level) level))]
    [else (flatten lst)]
    )
  )

(define i1 (map (lambda (word)
       (hash-ref test-ht word)
       ) (car test-words)))

(define i2 (map (lambda (word)
                  (make-level i1 2)
       ) i1))

i2

(define (is-contained? word rules)
  (define MAX (length word))
  (define (cyk level)
    level
    )
  (cyk 1)
  )

(define result1 '())

(println "Part 1 result is: ")
(println result1)


(define result2 '())

(println "Part 2 result is: ")
(println result2)

(test)
