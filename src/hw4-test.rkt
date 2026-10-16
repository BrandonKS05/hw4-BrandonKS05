#lang racket

(require rackunit)
(require rackunit/text-ui)
(require "hw4.rkt")

; CS 3270 instructor
; Vanderbilt University

(define-test-suite test-exercise-01
  (test-equal?
   "(word-total-tr (list (tile 'A 1 'none) (tile 'B 3 'none) (tile 'C 3 'none)))"
   (word-total-tr (list (tile 'A 1 'none) (tile 'B 3 'none) (tile 'C 3 'none))) 7)

  (test-equal?
   "(word-total-tr (list (tile 'A 1 'tl) (tile 'B 3 'dl) (tile 'C 3 'none)))"
   (word-total-tr (list (tile 'A 1 'tl) (tile 'B 3 'dl) (tile 'C 3 'none))) 12)

  (test-equal?
   "(word-total-tr (list (tile 'V 4 'tl) (tile 'A 1 'none) (tile 'N 1 'none) (tile 'D 2 'none) (tile 'E 1 'tl) (tile 'R 1 'none) (tile 'B 3 'none) (tile 'I 1 'none) (tile 'L 1 'tl) (tile 'T 1 'none)))"
   (word-total-tr (list (tile 'V 4 'tl) (tile 'A 1 'none) (tile 'N 1 'none) (tile 'D 2 'none) (tile 'E 1 'tl) (tile 'R 1 'none) (tile 'B 3 'none) (tile 'I 1 'none) (tile 'L 1 'tl) (tile 'T 1 'none))) 28))

(define-test-suite test-exercise-02
  (let
      ([date-lst '((2015 3 15) (2016 1 1) (2016 3 1) (2016 2 17))])
    (test-equal?
     "(number-in-month-tr '((2015 3 15) (2016 1 1) (2016 3 1) (2016 2 17)) 3)"
     (number-in-month-tr date-lst 3) 2)

    (test-equal?
     "(number-in-month-tr '((2015 3 15) (2016 1 1) (2016 3 1) (2016 2 17)) 1)"
     (number-in-month-tr date-lst 1) 1)

    (test-equal?
     "(number-in-month-tr '((2015 3 15) (2016 1 1) (2016 3 1) (2016 2 17)) 6)"
     (number-in-month-tr date-lst 6) 0)))

(define-test-suite test-exercise-03
  (test-equal?
   "(file-size-total-tr root-files-only)"
   (file-size-total-tr root-files-only) 15)

  (test-equal?
   "(file-size-total-tr repository)"
   (file-size-total-tr repository) 24)

  (test-equal?
   "(file-size-total-tr nested-folders)"
   (file-size-total-tr nested-folders) 96))

; Assumes that stream-for-n-steps has been defined.
(define-test-suite test-exercise-04
  (test-equal?
   "(stream-for-n-steps powers-of-two 0)"
   (stream-for-n-steps powers-of-two 0) '())

  (test-equal?
   "(stream-for-n-steps powers-of-two 1)"
   (stream-for-n-steps powers-of-two 1) '(2))

  (test-equal?
   "(stream-for-n-steps powers-of-two 5)"
   (stream-for-n-steps powers-of-two 5) '(2 4 8 16 32))

  (test-equal?
   "(stream-for-n-steps powers-of-two 10)"
   (stream-for-n-steps powers-of-two 10) '(2 4 8 16 32 64 128 256 512 1024)))

; Assumes that stream-for-n-steps has been defined.
(define-test-suite test-exercise-05
  (test-equal?
   "(stream-for-n-steps funky-stream 1)"
   (stream-for-n-steps funky-stream 1) '(1))

  (test-equal?
   "(stream-for-n-steps funky-stream 5)"
   (stream-for-n-steps funky-stream 5) '(1 2 3 4 -5))

  (test-equal?
   "(stream-for-n-steps funky-stream 10)"
   (stream-for-n-steps funky-stream 10) '(1 2 3 4 -5 6 7 8 9 -10)))

; Assumes that stream-for-n-steps has been defined.
(define-test-suite test-exercise-06
  (test-equal?
   "(stream-for-n-steps this-then-that 1)"
   (stream-for-n-steps this-then-that 1) '("If this"))

  (test-equal?
   "(stream-for-n-steps this-then-that 5)"
   (stream-for-n-steps this-then-that 5) '("If this" "Then that" "If this" "Then that" "If this"))

  (test-equal?
   "(stream-for-n-steps this-then-that 10)"
   (stream-for-n-steps this-then-that 10) '("If this"
                                            "Then that"
                                            "If this"
                                            "Then that"
                                            "If this"
                                            "Then that"
                                            "If this"
                                            "Then that"
                                            "If this"
                                            "Then that")))

; Assumes that stream-for-n-steps has been defined.
(define-test-suite test-exercise-07
  (test-equal?
   "(stream-for-n-steps (stream-add-zero powers-of-two) 1)"
   (stream-for-n-steps (stream-add-zero powers-of-two) 1) '((0 . 2)))

  (test-equal?
   "(stream-for-n-steps (stream-add-zero funky-stream) 5)"
   (stream-for-n-steps (stream-add-zero funky-stream) 5) '((0 . 1) (0 . 2) (0 . 3) (0 . 4) (0 . -5)))

  (test-equal?
   "(stream-for-n-steps (stream-add-zero powers-of-two) 10)"
   (stream-for-n-steps (stream-add-zero powers-of-two) 10) '((0 . 2)
                                                             (0 . 4)
                                                             (0 . 8)
                                                             (0 . 16)
                                                             (0 . 32)
                                                             (0 . 64)
                                                             (0 . 128)
                                                             (0 . 256)
                                                             (0 . 512)
                                                             (0 . 1024))))

; Set up test suite for all tests.
(define all-tests
  (test-suite
   "Homework 4"
   test-exercise-01
   test-exercise-02
   test-exercise-03
   test-exercise-04
   test-exercise-05
   test-exercise-06
   test-exercise-07))

; Run tests.
(run-tests all-tests)