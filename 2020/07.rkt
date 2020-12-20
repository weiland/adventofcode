#lang racket

(require test-engine/racket-tests)

(define DAY "7")

(define test-list (string-split "light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags." "\n"))
(define expected-number 4)

(define input (file->lines (string-append "./input/" DAY ".txt")))

(check-expect (not (empty? input)) #true)

(define-struct bag (amount color))
(define-struct rule (name children))

(define (row->rule row)
  (let ([pair (string-split (string-replace row #rx" bag(s?)(\\.?)" "") " contain ")]) 
    (make-rule (first pair)
               (map (lambda (str)
                      (make-bag
                        (first (string-split str " "))
                        (string-join (rest (string-split str " ")))
                      )
                    )
                    (string-split (second pair) ", "))
    )
  )
)

(check-expect (string-replace "light red bags contain 1 bright white bag, 2 muted yellow bags." #rx" bag(s?)(\\.?)" "") "light red contain 1 bright white, 2 muted yellow")

(check-expect (make-bag "1" "blue") (make-bag "1" "blue"))
(check-expect (rule-name (row->rule (first test-list))) "light red")
(check-expect (row->rule (first test-list)) (make-rule "light red" (list (make-bag "1" "bright white") (make-bag "2" "muted yellow"))))
(check-expect (first (rule-children (row->rule (first test-list)))) (make-bag "1" "bright white"))
(check-expect (second (rule-children (row->rule (first test-list)))) (make-bag "2" "muted yellow"))
(println (bag-amount (first (rule-children (row->rule (first test-list))))))
(println (bag-color (first (rule-children (row->rule (first test-list))))))

(define result1 '())

(println "Part 1 result is: ")
(println result1)


(define result2 '())

(println "Part 2 result is: ")
(println result2)

(test)
