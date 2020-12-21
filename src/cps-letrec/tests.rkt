#lang racket

(require rackunit)
(require rackunit/text-ui)
(require "./cps-letrec.rkt")

(define value-tests
  (test-suite
    "Values"
    (test-case
      "Numbers"
      (check-equal?  (cps-letrec '5) 5))
    (test-case
      "Symbols"
      (check-equal?  (cps-letrec '(quote x)) (quote x)))))

(define expression-tests
  (test-suite
    "Lookup (+,-,*,/ should be in the environment)"
    (test-case
      "+"
      (check-equal? (cps-letrec '(+ 2 3)) 5))
    (test-case
      "-"
      (check-equal? (cps-letrec '(- 5 2)) 3))
    (test-case
      "*"
      (check-equal? (cps-letrec '(* 3 4)) 12))
    (test-case
      "/"
      (check-equal? (cps-letrec '(/ 14 7)) 2))))

(define lambda-tests
  (test-suite
    "Application tests"
    (test-case
      "Identity application"
      (check-equal? (cps-letrec '((lambda (x) x) 5)) 5))
    (test-case
      "Square application"
      (check-equal? (cps-letrec '((lambda (x) (* x x)) 5)) 25))
    (test-case
      "Thunk evaluation"
      (check-equal? (cps-letrec '((lambda () (* 5 (/ 10 2))))) 25))))

(run-tests value-tests 'verbose)
(run-tests expression-tests 'verbose)
(run-tests lambda-tests 'verbose)