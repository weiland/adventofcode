#lang racket

(define ADD 1)
(define MUL 2)
(define HALT 99)

(define OFFSET 4)


(define (answer-part1 input) (first (run input)))

(define (run intcode)
  (parse-at intcode 12 2)
)

(define (parser offset intcode)
  (cond
    ; finished, return result (updated intcode)
    [(empty? intcode) intcode]
    ; first instruction is HALT, return result
    [(equal? (list-ref intcode offset) HALT) intcode]
    ;;; [(> (length intcode) offset) intcode]
    ; there is more intcode left, handle instruction and continue parsing
    [(> (- (length intcode) offset) OFFSET) (parser (+ offset OFFSET) (execute-instruction-at intcode offset))]
    ; otherwise just calculate instruction
    [else (execute-instruction-at intcode offset)]
  )
)

(define (execute-instruction-at intcode offset)
  (exec
    (opcode->operator (list-ref intcode offset))
    (list-ref intcode (+ offset 1))
    (list-ref intcode (+ offset 2))
    (list-ref intcode (+ offset 3))
    intcode
  )
)

(define (opcode->operator opcode)
  (cond
    [(equal? opcode ADD) +]
    [(equal? opcode MUL) *]
    ;[(equal? opcode HALT) -1] ; should be handled before
    [else (error "Invalid Opcode")]
  )
)

(define (exec op posA posB targetPosition intcode)
  (list-set intcode targetPosition (op (list-ref intcode posA) (list-ref intcode posB)))
)

(define (answer-part2 input)
  (check-result (parse-noun input 0))
)

(define (check-result input)
  (cond
    [(equal? (length input) 2) (+ (* 100 (first input)) (second input))]
    [#t #f]
  )
)

(define (parse-noun intcode noun)
  (cond
    ; parse-ver runs twice (but i'm lazy)
    [(not (empty? (parse-verb intcode noun 0))) (parse-verb intcode noun 0)]
    [(< noun 99) (parse-noun intcode (+ 1 noun))]
    [#t '()]
  )
)

(define (parse-verb intcode noun verb)
  (cond
    [(found? (parse-at intcode noun verb)) (list noun verb)]
    [(< verb 99) (parse-verb intcode noun (+ 1 verb))]
    [#t '()]
  )
)

(define (parse-at intcode noun verb)
  (parser 0 (list-set (list-set intcode 1 noun) 2 verb))
)

(define EXPECTED 19690720)
(define (found? intcode)
  (equal? (first intcode) EXPECTED)
)

(provide parser run answer-part1 answer-part2)
