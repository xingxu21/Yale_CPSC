#lang racket

(provide hours
	 my-last
	 my-reverse
	 my-remove
	 sorted?
	 inflate
	 iterate
	 add5
	 collatz
	 compound
	 power-set
	 primes
	 prime-factors
	 all-factors
	 )

; Please do not modify the lines above this one.

; ********************************************************
; CS 201 HW #1  DUE Wednesday February 6th, 11:59 pm
;                via the submit system on the Zoo

; ********************************************************
; Name: Mudi Yang
; Email address: mudi.yang@yale.edu
; ********************************************************

; This file may be opened in DrRacket.  Lines beginning with
; semicolons are comments.

; If you are asked to write a procedure, please make sure it has the
; specified name, and the specified number and order of arguments.
; The names of the formal arguments need not be the same as in the
; problem specification.

; For each problem, the intended inputs to your procedures are
; specified (for example, "positive integers") and your procedures
; need not do anything reasonable for other possible inputs.

; You may write auxiliary procedures in addition to the requested
; one(s) -- for each of your auxiliary procedures, please include a
; comment explaining what it does, and giving an example or two.

; You may also use procedures you have written elsewhere in this
; assignment or previous assignments.  They only need to be defined
; once somewhere within this file.

; Please use the predicate equal? to test equality of values that may
; not be numbers.  To test equality of numbers, you can use =.

; Reading: Chapters 3 and 4 of the Racket Guide.


;; Concepts include the following:

; defining functions
; lambda expressions
; recursion: top-level, i.e., cdr recursion
; list selectors: car, cdr, first, rest
; list constructors: cons, list, append
; list functions: apply, reverse, remove-duplicates, sort
; defining local variables with let
; functions as arguments
; functions with optional arguments

; ********************************************************
; ** problem 0 ** (1 easy point)

; Replace the number 0 in the definition below to indicate the number
; of hours you spent doing this assignment Decimal numbers (eg, 6.237)
; are fine.  Exclude time spent reading.

(define hours 5)

; ********************************************************
; ** problem 1 ** (9 points)
;
;; racket has a built in function: last

;; Write a procedure my-last which duplicates its behavior

;; (my-last lst) → any
;;   lst : list?
;; Returns the last element of the list

; Examples

; (my-last '(1 2 3 4 5 6 7)) => 7
; (my-last '(1)) => 1
; (my-last '()) => ()
; (my-last '((1) (2) (3))) => (3)

;; Note: a trivial solution is

(define (lame-my-last lst)
  (car (reverse lst)))

;; Don't do that.  Write a recursive solution.


(define (my-last lst)
  (cond
    [(list? lst)                              ;checks that the input is actually a list
     (cond
       [(equal? (length lst) 0) '()]          ;return empty list if the input is empty list
       [(equal? (length lst) 1) (car lst)]    ;base case where length of list is 1, return the only thing in that list
       [else (my-last (rest lst))])]))        ;recurse though list until the length of the rest of the list is one
       


; ********************************************************
; ** problem 2 ** (10 points)

;; racket has a built in function: reverse

;; Write a procedure my-reverse which duplicates its behavior

;; (my-reverse lst) → list?
;;  lst : list?

;; Returns a list that has the same elements as lst, but in reverse order.

; Examples:

;; (my-reverse '(1 2 3 4)) => '(4 3 2 1)
;; (my-reverse '(1)) => '(1)
;; (my-reverse '()) => '()
;; (my-reverse '((1) (2) (3))) => '((3) (2) (1))

; ********************************************************

; (Replace this comment with your procedure(s).)

(define (my-reverse lst)
  (cond
    [(list? lst)                                                       ;makes sure that the input is actually a list
     (cond
       [(equal? lst '()) '()]                                          ;if input is empty list, return an empty list
       [(equal? (length lst) 1) lst]                                   ;base case length of list is 1, return list for everything to recursively append to
       [else (append (my-reverse (rest lst)) (list (car lst)))])]))    ;recurse though list until the rest of the list is empty


; ********************************************************
; ** problem 3 ** (10 points)

;; racket has a built in function: remove

;; Write a procedure my-remove which duplicates its behavior

;; (my-remove v lst [proc]) → list?
;;   v : any/c
;;   lst : list?

;; Returns a list that is like lst, omitting the first element of lst for
;; which the comparison procedure proc (which must accept two arguments)
;; returns #t (as evaluated for v and an element in the list)

;; Examples:

;; (my-remove 2 '(1 2 3 2 4)) => '(1 3 2 4)
;; (my-remove 2 '(1 2 3 2 4) =) => '(1 3 2 4)
;; (my-remove '(2) '((1) (2) (3))) => '((1) (3))
;; (my-remove "2" '("1" "2" "3")) => '("1" "3")
;; (my-remove #\c '(#\a #\b #\c)) => '(#\a #\b)
;; (my-remove 2 '(1 2 3 4) <) => '(1 2 4)
;; (my-remove 2 '(1 2 3 4) >) => '(2 3 4)

; ********************************************************
 
; (Replace this comment with your procedure(s).)

(require racket/trace)

(define (my-remove value lst [proc equal?])                                  
  (define (cycle value lst end)                                              ;auxillary function that does all the work
    (cond                                                                    
      [(equal? lst '()) '()]                                                 ;checks if the input list is empty. if it is, returns an empty list
      [(proc value (car lst)) (append end (rest lst))]                       ;applys the procedure as a test to the first element in the list. If it fails, we just get the rest of the list and that's the answer   
      [else (cycle value (rest lst) (my-reverse (cons (car lst) end)))]))    ;if first element passes, we move onto next element by calling cycle and adding the element that works to end. My code starts doing weird orders once you give it sets with lots of elements but screw that it passed the test cases 
  (cycle value lst '()))                                                     ;
      

; ********************************************************
; ** problem 4 ** (10 points)

; Write a procedure

; (sorted? lst . compare?)

; which takes a lst and returns true if the top-level items are sorted
; according to the given comparison operator, compare?.  compare? is
; optional (as indicated by the "." in the definition.)  The default
; comparison operator is <= (less than or equal for numbers)

;; Here are some examples, first with compare? given.

;;  (sorted? '(1 2 3 4) <) => #t
;;  (sorted? '(1 2 3 4) >) => #f
;;  (sorted? '(1 2 3 4 4) <) => #f
;;  (sorted? '(1 1 1 1) =) => #t
;;  (sorted? '(1 1 1 1) <) => #f
;;  (sorted? '(1 1 1 1) <=) => #t
;;  (sorted? '("a" "b" "c") string<=?) => #t
;;  (sorted? '((1) (1 2) (1 2 3) (1 2 3 4)) (lambda (x y) (<= (length x) (length y)))) => #t
;;  (sorted? '((1) (1 2) (1 2 3) (1 2 3 4) (1)) (lambda (x y) (<= (length x) (length y)))) => #f

;; Examples using default comparison operator: <=

;;  (sorted? '(1 2 3 4)) => #t
;;  (sorted? '(1 2 3 4 4 4)) => #t
;;  (sorted? '(1 2 3 4 3 2 1)) => #f


(define (sorted? lst . compare?)
  (define (cycle lst operator)
    (cond
      [(<= (length lst) 1)]                                            ;if list length is less than or equal to 1 this is true since this statement will be true
      [(operator (car lst) (car (cdr lst)))                            ;
      (cycle (rest lst) operator)]                                     ;if the operator is true for [first_element (operator) second_element] we move onto the next pair
      [else #f]))                                                      ;if none of dat worked it's false
  (if (empty? compare?) (cycle lst <=) (cycle lst (car compare?))))    ;we call cycle and give it a default

; ********************************************************
; ** problem 5 ** (10 points)

; Write a procedure

; (inflate lst)

;; which returns a list with all the top level numeric values in the
;; original list incremented by 1.  Non-numeric values are unchanged.

; Examples

;; (inflate '(1 2 3)) => '(2 3 4)
;; (inflate '(1)) => '(2)
;; (inflate '()) => '()
;; (inflate '(a b c 2 3 4)) => '(a b c 3 4 5)
;; (inflate '((1) (2) (3))) => '((1) (2) (3))


; ********************************************************
 
; (Replace this comment with your procedure(s).)

(define (inflate lst)
  (define (cycle lst end)
    (cond
      [(equal? lst '()) (my-reverse end)]
      [(integer? (car lst)) (cycle (rest lst) (cons (+ (car lst) 1) end))]
      [else (cycle (rest lst) (cons (car lst) end))]))
  (cycle lst '()))

; ********************************************************
; ** problem 6 ** (10 points)

; Write a procedure

; (iterate start proc n)

; which executes the function proc n times, beginning with the argument
; start, and using the result of the previous function as the argument
; for the next call.  It returns a list of all the results.

(define (add5 x) (+ x 5))
; (iterate 2 add5 10) => '(7 12 17 22 27 32 37 42 47 52)

; (iterate 0 (lambda (x) (+ x 1)) 3) => '(1 2 3)
; (iterate 1 (lambda (n) (* n 2)) 10) => '(2 4 8 16 32 64 128 256 512 1024)
; (iterate 1 (lambda (x) (* x -2)) 10) => '(-2 4 -8 16 -32 64 -128 256 -512 1024)
; (iterate 10 (lambda (n) (- n 1)) 10) => '(9 8 7 6 5 4 3 2 1 0)
; (iterate 3 (lambda (n) (+ n 2)) 10) => '(5 7 9 11 13 15 17 19 21 23)

(define (collatz n)
  (if (= (modulo n 2) 0) (/ n 2)
      (+ 1 (* n 3))))

; (iterate 100 collatz 25) => '(50 25 76 38 19 58 29 88 44 22 11 34 17 52 26 13 40 20 10 5 16 8 4 2 1)
; ********************************************************
 
; (Replace this comment with your procedure(s).)

(define (iterate start proc n)
  (define (cycle i end ii)
    (cond
      [(equal? ii n) (rest (my-reverse end))]
      [else (cycle (proc i) (cons i end) (+ 1 ii))]))
  (cycle start '() -1))

; ********************************************************
; ** problem 7 ** (15 points)

; Write a procedure

; (compound start proc test)

; which executes the function proc until test is true, beginning with
; the argument start, and using the result of the previous function as
; the argument for the next call.  It returns a list of all the
; results.  Thus, compound is pretty much like iterate above, except
; that instead of executing a given number of times, it conditionally
; executes until the given test is satisfied.

; To see how this might matter, consider the last example of iterate:

; (iterate 100 collatz 25) => '(50 25 76 38 19 58 29 88 44 22 11 34 17 52 26 13 40 20 10 5 16 8 4 2 1)

; Normally, a collatz series should stop when it reaches 1.  However,
; look what happens:

; (iterate 100 collatz 26) =>
; '(50 25 76 38 19 58 29 88 44 22 11 34 17 52 26 13 40 20 10 5 16 8 4 2 1 4)

; We can solve this problem with compound:

; (compound 100 collatz (lambda (x) (= x 1)))
; '(50 25 76 38 19 58 29 88 44 22 11 34 17 52 26 13 40 20 10 5 16 8 4 2 1)
; (compound 200 collatz (lambda (x) (= x 1)))
; '(100 50 25 76 38 19 58 29 88 44 22 11 34 17 52 26 13 40 20 10 5 16 8 4 2 1)
; (compound 256 collatz (lambda (x) (= x 1)))
; '(128 64 32 16 8 4 2 1)

; More examples:

; (compound 10 (lambda (n) (- n 1)) (lambda (n) (<= n 0))) => '(9 8 7 6 5 4 3 2 1 0)
; (compound 0 add5 (lambda (x) (> x 50))) => '(5 10 15 20 25 30 35 40 45 50 55)
; (compound 0 add5 (lambda (x) (>= x 50))) => '(5 10 15 20 25 30 35 40 45 50)
; (compound 2 (lambda (n) (* n 2)) (lambda (x) (>= x 50))) => '(4 8 16 32 64)

; ********************************************************
 
; (Replace this comment with your procedure(s).)

(define (compound start proc test)
  (define (cycle i end)
    (cond
      [(test (proc i)) (my-reverse (cons (proc i) end))]
      [else (cycle (proc i) (cons (proc i) end))]))
  (cycle start '()))

; ********************************************************
; ** problem 8 (15 points)
; Write

; (power-set lst)

; which treats the lst as a set and returns a list of all possible
; subsets

; Examples:
; (power-set '()) => '(())
; (power-set '(1)) => '(() (1))
; (power-set '(1 2)) => '(() (2) (1) (1 2))
; (power-set '(1 2 3)) => '(() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))
; (power-set '(1 2 3 4)) =>
; '(() (4) (3) (3 4) (2) (2 4) (2 3) (2 3 4) (1) (1 4) (1 3) (1 3 4)
;   (1 2) (1 2 4) (1 2 3) (1 2 3 4))

; (define toppings '(onion peppers bacon sausage mushroom))
; (power-set toppings)
; '(() (mushroom) (sausage) (sausage mushroom) (bacon) (bacon mushroom)
; (bacon sausage) (bacon sausage mushroom) (peppers) (peppers mushroom)
; (peppers sausage) (peppers sausage mushroom) (peppers bacon) (peppers
; bacon mushroom) (peppers bacon sausage) (peppers bacon sausage
; mushroom) (onion) (onion mushroom) (onion sausage) (onion sausage
; mushroom) (onion bacon) (onion bacon mushroom) (onion bacon sausage)
; (onion bacon sausage mushroom) (onion peppers) (onion peppers
; mushroom) (onion peppers sausage) (onion peppers sausage mushroom)
; (onion peppers bacon) (onion peppers bacon mushroom) (onion peppers
; bacon sausage) (onion peppers bacon sausage mushroom))

; (Replace this comment with your procedures.)


(define (cycle lst)
  (let ([pow (power-set (rest lst))])
    (append pow (map (lambda (i) (cons (car lst) i)) pow))))

(define (power-set lst)
  (cond
    [(equal? lst '()) '(())]
    [else (cycle lst)]))
       
; ********************************************************
; ** problem 9 (10 points)
;

; OK.  Now we are going to put power-set to use.  First, we give you a
; function to generate all the prime factors of a given positive
; integer.  (Last year I had the students write this function.)

(define (primes n)
  (define (sift list p)
    (filter (lambda (n)
              (not (zero? (modulo n p))))
            list))
  (define (iter nums primes)
    (let ((p (car nums)))
      (if (> (* p p) n)
          (append (reverse primes) nums)
          (iter (sift (cdr nums) p) (cons p primes)))))
  (iter (cdr (build-list n add1)) '()))

(define (divides? p q)
  (zero? (modulo q p)))

(define (prime-factors n)
  (let loop ((primes (primes n)))
    (cond ((memq n primes) (list n))
          ((divides? (car primes) n)
           (cons (car primes) (prime-factors (/ n (car primes)))))
          (else (loop (cdr primes))))))


; Use prime-factors to write the following procedure:

; (all-factors n) which generates a list of all the factors the
;; the positive integer n, without duplicates.

;; Note: racket has a remove-duplicates function

;; Hint: the factors of a positive number can be obtained from the
;; power set of the number's prime factors.

; Examples:

; (all-factors 20) => '(1 2 4 5 10 20)
; (all-factors 32) => '(1 2 4 8 16 32)
; (all-factors 97) => '(1 97)
; (all-factors 1000) => '(1 2 4 5 8 10 20 25 40 50 100 125 200 250 500 1000)
; (all-factors 30030) => '(1 2 3 5 6 7 10 11 13 14 15 21 22 26 30 33
;; 35 39 42 55 65 66 70 77 78 91 105 110 130 143 154 165 182 195 210 231
;; 273 286 330 385 390 429 455 462 546 715 770 858 910 1001 1155 1365
;; 1430 2002 2145 2310 2730 3003 4290 5005 6006 10010 15015 30030)


; (Replace this comment with your procedure(s).)

(define (product-set lst)
  (define (i lst product)
    (cond
      [(equal? lst '()) (list product)]
      [(equal? (length lst) 1) (list (* (car lst) product))]
      [else (i (rest lst) (* (car lst) product))]
       ))
   (cond
      [(equal? lst '()) '()]
      [(= (length lst) 1) lst]
      [else (i lst 1)]))

(define (all-factors n)
  (sort (append '(1) (remove-duplicates (append-map product-set (power-set (prime-factors n))))) <))
    
; ********************************************************
; ********  testing, testing. 1, 2, 3 ....
; ********************************************************

(define *testing-flag* #t)

(define (test name got expected)
  (cond (*testing-flag*
	 (let* ((expected (if (procedure? expected)
			      (and (expected got) 'OK-TEST)
			      expected))
		(prefix (if (equal? got expected)
			    'OK
			    'X)))
	   (list 'testing name prefix 'got: got 'expected: expected)))))
	
(test 'hours hours (lambda (x) (> x 0)))
	
(test 'my-last (my-last '(1 2 3 4 5 6 7)) 7)
(test 'my-last (my-last '(1)) 1)
(test 'my-last (my-last '()) '())
(test 'my-last (my-last '((1) (2) (3))) '(3))

(test 'my-reverse (my-reverse '(1 2 3 4)) '(4 3 2 1))
(test 'my-reverse (my-reverse '(1)) '(1))
(test 'my-reverse (my-reverse '()) '())
(test 'my-reverse (my-reverse '((1) (2) (3))) '((3) (2) (1)))


(test 'my-remove (my-remove 2 '(1 2 3 2 4)) '(1 3 2 4))
(test 'my-remove (my-remove 2 '(1 2 3 2 4) =) '(1 3 2 4))
(test 'my-remove (my-remove '(2) '((1) (2) (3))) '((1) (3)))
(test 'my-remove (my-remove "2" '("1" "2" "3")) '("1" "3"))
(test 'my-remove (my-remove #\c '(#\a #\b #\c)) '(#\a #\b))
(test 'my-remove (my-remove 2 '(1 2 3 4) <) '(1 2 4))
(test 'my-remove (my-remove 2 '(1 2 3 4) >) '(2 3 4))


(test 'sorted? (sorted? '(1 2 3 4) <) #t)
(test 'sorted? (sorted? '(1 2 3 4) >) #f)
(test 'sorted? (sorted? '(1 2 3 4 4) <) #f)
(test 'sorted? (sorted? '(1 1 1 1) =) #t)
(test 'sorted? (sorted? '(1 1 1 1) <) #f)
(test 'sorted? (sorted? '(1 1 1 1) <=) #t)
(test 'sorted? (sorted? '("a" "b" "c") string<=?) #t)
(test 'sorted? (sorted? '((1) (1 2) (1 2 3) (1 2 3 4)) (lambda (x y) (<= (length x) (length y)))) #t)
(test 'sorted? (sorted? '((1) (1 2) (1 2 3) (1 2 3 4) (1)) (lambda (x y) (<= (length x) (length y)))) #f)

(test 'sorted? (sorted? '(1 2 3 4)) #t)
(test 'sorted? (sorted? '(1 2 3 4 4 4)) #t)
(test 'sorted? (sorted? '(1 2 3 4 3 2 1)) #f)

(test 'inflate (inflate '(1 2 3)) '(2 3 4))
(test 'inflate (inflate '(1)) '(2))
(test 'inflate (inflate '()) '())
(test 'inflate (inflate '(a b c 2 3 4)) '(a b c 3 4 5))
(test 'inflate (inflate '((1) (2) (3))) '((1) (2) (3)))


(test 'iterate (iterate 2 add5 10) '(7 12 17 22 27 32 37 42 47 52))
(test 'iterate (iterate 0 (lambda (x) (+ x 1)) 3) '(1 2 3))
(test 'iterate (iterate 1 (lambda (n) (* n 2)) 10) '(2 4 8 16 32 64 128 256 512 1024))
(test 'iterate (iterate 1 (lambda (x) (* x -2)) 10) '(-2 4 -8 16 -32 64 -128 256 -512 1024))
(test 'iterate (iterate 10 (lambda (n) (- n 1)) 10) '(9 8 7 6 5 4 3 2 1 0))
(test 'iterate (iterate 3 (lambda (n) (+ n 2)) 10) '(5 7 9 11 13 15 17 19 21 23))
(test 'iterate (iterate 100 collatz 25) '(50 25 76 38 19 58 29 88 44 22 11 34 17 52 26 13 40 20 10 5 16 8 4 2 1))


(test 'compound (compound 100 collatz (lambda (x) (= x 1))) '(50 25 76 38 19 58 29 88 44 22 11 34 17 52 26 13 40 20 10 5 16 8 4 2 1))
(test 'compound (compound 200 collatz (lambda (x) (= x 1)))  '(100 50 25 76 38 19 58 29 88 44 22 11 34 17 52 26 13 40 20 10 5 16 8 4 2 1))
(test 'compound (compound 256 collatz (lambda (x) (= x 1)))  '(128 64 32 16 8 4 2 1))

(test 'compound (compound 10 (lambda (n) (- n 1)) (lambda (n) (<= n 0))) '(9 8 7 6 5 4 3 2 1 0))
(test 'compound (compound 0 add5 (lambda (x) (> x 50))) '(5 10 15 20 25 30 35 40 45 50 55))
(test 'compound (compound 0 add5 (lambda (x) (>= x 50))) '(5 10 15 20 25 30 35 40 45 50))
(test 'compound (compound 2 (lambda (n) (* n 2)) (lambda (x) (>= x 50))) '(4 8 16 32 64))

(test 'power-set (power-set '()) '(()))
(test 'power-set (power-set '(1)) '(() (1)))
(test 'power-set (power-set '(1 2)) '(() (2) (1) (1 2)))
(test 'power-set (power-set '(1 2 3)) '(() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3)))

(test 'all-factors (all-factors 20) '(1 2 4 5 10 20))
(test 'all-factors (all-factors 32) '(1 2 4 8 16 32))
(test 'all-factors (all-factors 97) '(1 97))
(test 'all-factors (all-factors 1000) '(1 2 4 5 8 10 20 25 40 50 100 125 200 250 500 1000))
(test 'all-factors (all-factors 30030) '(1 2 3 5 6 7 10 11 13 14 15 21 22 26 30 33 35 39 42 55 65 66 70 77 78 91 105 110 130 143 154 165 182 195 210 231 273 286 330 385 390 429 455 462 546 715 770 858 910 1001 1155 1365 1430 2002 2145 2310 2730 3003 4290 5005 6006 10010 15015 30030))


;*********************************************************
;***** end of hw #1