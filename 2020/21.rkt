#lang racket

(require test-engine/racket-tests)

(define DAY "21")
(define (line->food str)
  (let ((pair (string-split str " (contains ")))
    (list
      (string-split (car pair) " ")
      (string-split (string-replace (second pair) ")" "") ", "))
  ))
(define (parse-food food ht)
    ht
  )
(define (foods->ht foods)
  (foldl parse-food (hash) foods)
  )
(define input (map line->food (file->lines (string-append "./input/" DAY ".txt"))))
(define test-input (map line->food (list "mxmxvkd kfcds sqjhc nhms (contains dairy, fish)" "trh fvjkl sbzzf mxmxvkd (contains dairy)" "sqjhc fvjkl (contains soy)" "sqjhc mxmxvkd sbzzf (contains fish)")))
(check-expect (not (empty? input)) #t)

;; return all ingredients for an allergene
(define (filter-allergene foods allergene)
  (filter values
    (map
      (lambda (food)
        (if
          (not (not (member allergene (second food))))
          (car food)
          #f))
      foods)))

;; allergenes -> ingredients (injective but not surjective)
;; 42 foods, 32 unique
;; 2704 ingredients, 200 unique
;; 78 allergenes, 8 unique
(define allergenes (remove-duplicates (flatten (map second input))))
(define ingredients (remove-duplicates (flatten (map car input))))
(define test-allergenes (remove-duplicates (flatten (map second test-input))))
(define test-ingredients (remove-duplicates (flatten (map car test-input))))


;; (list of lists) -> (set of all intersects)
(define (intersect lists)
  (if (empty? lists)
      (set )
      (apply set-intersect (map list->set lists))
      ))

(define (ingredients-found foods allergenes)
  (apply set-union
    (map
      (lambda (allergene)
        (intersect (filter-allergene foods allergene)))
      allergenes)))

(define (leftover-ingredients foods ingredients allergenes)
  (set-subtract (list->set ingredients) (ingredients-found foods allergenes)))

; (set-count (leftover-ingredients input)) ;; 192
(define (ingredient-occurrence ingredient foods)
  (foldl
    (lambda (i res)
      (if (equal? ingredient i) (add1 res) res)
      ) 0 (flatten (map car foods))))


(define (solve-part-one foods ingredients allergenes)
  (apply +
         (set-map
           (leftover-ingredients foods ingredients allergenes)
           (lambda (i) (ingredient-occurrence i foods)))))


(define (fm foods allergenes)
    (map
      (lambda (allergene)
        (list allergene (intersect (filter-allergene foods allergene))))
      allergenes))

(define (extract-set-count lst)
  (set-count (second lst)))

; (sort (fm test-input (sort test-allergenes string<?)) #:key extract-set-count <)

(define (solve-part-two foods allergenes)
  ; (string-join
  ;   (reverse
  ;     (set->list
        (foldl
          (lambda (i st)
            (let ((s (second i)))
              (set-add st
              (if
                (= (set-count s) 1)
                (set-first s)
                (set-first (set-subtract s st))
                ))))
          (set )
          (sort (fm foods (sort allergenes string<?)) #:key extract-set-count <))
        ;))
        ; ",")
  )

(println "Part 1 result is: ")
(solve-part-one input ingredients allergenes)
(check-expect (solve-part-one test-input test-ingredients allergenes) 5)


(println "Part 2 result is: ")
(solve-part-two input allergenes)
; (check-expect (solve-part-two test-input test-allergenes) "mxmxvkd,sqjhc,fvjkl")

(test)
