#lang racket

(provide hours
	 bmi
	 zodiac)

; Please do not modify the lines above this one.

; ********************************************************
; CS 201 HW #0  DUE Wednesday 1/30/19, 11:59 pm
; ** using the Zoo submit system **

; ********************************************************
; Name: Mudi Yang
; Email address: mudi.yang@yale.edu
; ********************************************************

; This file may be loaded into Racket.  Lines beginning with
; semicolons are comments.

; Homework #0 will be worth 20 points -- other homeworks will be worth
; 100 points (or so).  One purpose of homework #0 is to make sure you
; can use the submit system on the Zoo.  You will receive no credit
; for this assignment until you successfully use the submit system to
; submit it.

; You will be submitting *two* files for homework #0.  Please name
; them: hw0.rkt (for the Racket definitions and procedures)
; response.pdf (for the reading response)

; ********************************************************
; ** problem 0 ** (1 easy point) 

; Replace the number 0 in the definition below to indicate how many
; hours you spent doing this assignment.  Fractions are fine, eg,
; 3.14159.  You will receive no credit for this problem if you leave
; the number as 0.

(define hours 3)

; ********************************************************
; ** problem 1 ** (5 points)

; Write a procedure (bmi mass height)

; See https://en.wikipedia.org/wiki/Body_mass_index

; Obesity and BMI

; Adolphe Quetelet, a Belgian astronomer, mathematician, statistician
; and sociologist, devised the basis of the BMI between 1830 and 1850 as
; he developed what he called "social physics". The modern term "body
; mass index" (BMI) for the ratio of human body weight to squared height
; was coined in a paper published in the July 1972 edition of the
; Journal of Chronic Diseases by Ancel Keys and others. In this paper,
; Keys argued that what he termed the BMI was "...if not fully
; satisfactory, at least as good as any other relative weight index as
; an indicator of relative obesity".

; The formula is:

;  [(mass in pounds) / (height in inches)^2] * 703

; Examples


; ********************************************************

; Replace "empty" in the code below with your procedure.  Make sure it
; is named bmi and has two arguments.  The names of the arguments are
; not important.

; Your procedure will be tested automatically with two integer
; arguments.

(define (bmi mass height)
  (define bmi_exact (* (/ mass (* height height)) 703))
  (exact-floor bmi_exact))


; ********************************************************
; ** problem 2 ** (4 points)

; Write a procedure (zodiac) that takes no arguments and returns a
; *string* indicating your astrological sign.

; Please remember the difference between a procedure call and the
; evaluation of a variable!

; Example (yours will likely be different)

; (zodiac) => "Taurus"

; ********************************************************

; Replace "empty" in the code below with your procedure.  Make sure it
; is named zodiac and takes no arguments.  Your procedure will be
; tested automatically, and will be called only with no arguments.

(define (zodiac)
  "Virgo")

; ********************************************************
; ** problem 3 ** (10 points)

; For this problem, you are asked to find one article (of 2 pages or
; more) in the magazine "Communications of the ACM", in one of the
; issues: October, November, December 2018 See http://cacm.acm.org/

; read the article and answer the following three questions:

;   a. What did you know about the topic
;      prior to reading the article?
;   b. What did you learn from reading the
;      article?
;   c. What more would you like to know
;      about the topic?

; Your answer should be AT MOST 2 pages saved in pdf format, and
; submitted as the file response.pdf for assignment 0.  Please include
; in your file your name and email address and the title and author(s)
; of the article you are responding to.

; Your grade for this problem will be 10 if we can open, print and read
; your submitted pdf file.  It is to help us get acquainted with you
; and your interests -- you won't receive feedback on your answers.

; ********************************************************
; ********  testing, testing. 1, 2, 3 ....
; ********************************************************

(define *testing-flag* #t)

(define (test name got expected)
  (cond (*testing-flag*
	 (let* ((expected (if (procedure? expected)
			      (if (expected got) 'OK-TEST
				  'FAILED-TEST)
			      expected))
		(prefix (if (equal? got expected)
			    'OK
			    'X)))
	   (list 'testing name prefix 'got: got 'expected: expected)))))

(test 'hours hours (lambda (x) (> x 0)))
(test 'bmi (bmi 150 70) 21)
(test 'bmi (bmi 200 70) 28)
(test 'bmi (bmi 250 60) 48)
(test 'bmi (bmi 150 80) 16)
(test 'zodiac (zodiac) (lambda (x) (string? x)))

; ********************************************************
; ********  end of homework #0
; ********************************************************
