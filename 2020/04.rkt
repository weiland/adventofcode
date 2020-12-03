#lang racket

(require test-engine/racket-tests)

(define DAY "4")

(define test-input
  "ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
byr:1937 iyr:2017 cid:147 hgt:183cm

iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
hcl:#cfa07d byr:1929

hcl:#ae17e1 iyr:2013
eyr:2024
ecl:brn pid:760753108 byr:1931
hgt:179cm

hcl:#cfa07d eyr:2025 pid:166559648
iyr:2011 ecl:brn hgt:59in"
)
(define expected-number 2)

(define input (file->string (string-append "./input/" DAY ".txt")))

(check-expect (not (empty? input)) #true)

(define (passports text) (string-split text "\n\n"))

(check-expect (length (passports test-input)) 4)

(define (obtain-field full) (first (string-split full ":")))
(check-expect (obtain-field "asdf:234bbb") "asdf")

(define (obtain-value full) (last (string-split full ":")))
(check-expect (obtain-value "asdf:234bbb") "234bbb")

(define (fields passport) (map obtain-field (string-split (string-replace passport "\n" " ") " ")))

(check-expect (length (fields (first (passports test-input)))) 8)
(check-expect (length (fields (second (passports test-input)))) 7)
(check-expect (first (fields (first (passports test-input)))) "ecl")
(check-expect (first (fields (second (passports test-input)))) "iyr")

(define required-fields '("byr" "iyr" "eyr" "hgt" "hcl" "ecl" "pid"))

(check-expect  (member "asdf" required-fields) #f)
(check-expect (not(member "asdf" required-fields)) #t)
(check-expect (not(member "byr" required-fields)) #f)

(define (valid-passport? fields)
  (foldr (lambda (field result)
           (cond
             [(not result) #f]
             [#t (not (not (member field fields)))])
           ) #t required-fields))

(define test-passports (map fields (passports test-input)))
(println (first test-passports))
(check-expect (valid-passport? (first test-passports)) #t)
(check-expect (valid-passport? (second test-passports)) #f)
(check-expect (valid-passport? (third test-passports)) #t)
(check-expect (valid-passport? (fourth test-passports)) #f)

; (println (length (passports input)))

(define (valid-passports ipt)
  (map fields (passports ipt))
  )

(define result1 (length (filter (lambda (p) p) (map valid-passport? (valid-passports input)))))

(println "Part 1 result is: ")
(println result1)

(check-expect (number? (string->number (string-replace "#123abc" "#" "") 16)) #t)
(check-expect (number? (string->number "123abc" 16)) #t)
(check-expect (number? (string->number "123abz" 16)) #f)

(define (get-number value) (string->number (substring value 0 (- (string-length value) 2))))

(check-expect (get-number "1cm") 1)
(check-expect (get-number "22cm") 22)
(check-expect (get-number "123in") 123)

(define (validate p value)
  (cond
    [(equal? p "byr") (and (<= 1920 (string->number value)) (>= 2002 (string->number value)))]
    [(equal? p "iyr") (and (<= 2010 (string->number value)) (>= 2020 (string->number value)))]
    [(equal? p "eyr") (and (<= 2020 (string->number value)) (>= 2030 (string->number value)))]
    [(equal? p "hgt") 
      (cond
        [(string-suffix? value "cm") (and (<= 150 (get-number value)) (>= 193 (get-number value)))]
        [(string-suffix? value "in") (and (<= 59 (get-number value)) (>= 76 (get-number value)))]
        [#t #f]
        )]
    [(equal? p "hcl") (if (not (string-prefix? value "#")) #f (number? (string->number (string-replace value "#" "") 16)))]
    [(equal? p "ecl") (not (not (member value '("amb" "blu" "brn" "gry" "grn" "hzl" "oth"))))]
    [(equal? p "pid") (equal? 9 (string-length value))]
    [(equal? p "cid") #t]
    [#t #f]
    ))

(check-expect (validate "byr" "2002") #t)
(check-expect (validate "byr" "2003") #f)
(check-expect (validate "hgt" "60in") #t)
(check-expect (validate "hgt" "190cm") #t)
(check-expect (validate "hgt" "190in") #f)
(check-expect (validate "hgt" "190") #f)
(check-expect (validate "hcl" "#123abc") #t)
(check-expect (validate "hcl" "#123abz") #f)
(check-expect (validate "hcl" "123abc") #f)
(check-expect (validate "ecl" "brn") #t)
(check-expect (validate "ecl" "wat") #f)
(check-expect (validate "pid" "000000001") #t)
(check-expect (validate "pid" "0123456789") #f)
(check-expect (validate "cid" "iasdf") #t)
(check-expect (validate "asdf" "iasdf") #f)


(define (valid-passport-two? fields)
  (empty? (filter identity (map (lambda (fds) (validate (first fds) (last fds))) fields)))
  )

(define (passports-two input)
  (map (lambda (passport) (map (lambda (kv) (string-split kv ":")) (string-split (string-replace passport "\n" " ") " "))) (passports input))
  )

(define (valid-passports-two input) (passports-two input))

(define ivp "eyr:1972 cid:100
hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926

iyr:2019
hcl:#602927 eyr:1967 hgt:170cm
ecl:grn pid:012533040 byr:1946

hcl:dab227 iyr:2012
ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277

hgt:59cm ecl:zzz
eyr:2038 hcl:74454a iyr:2023
pid:3556412378 byr:2007")

(define vp "pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980
hcl:#623a2f

eyr:2029 ecl:blu cid:129 byr:1989
iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm

hcl:#888785
hgt:164cm byr:2001 iyr:2015 cid:88
pid:545766238 ecl:hzl
eyr:2022

iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719")

(println (map valid-passport-two? (passports-two vp)))
(println (map valid-passport-two? (passports-two ivp)))


(define result2 '())

(println "Part 2 result is: ")
(println result2)

(test)
