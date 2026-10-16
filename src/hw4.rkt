#lang racket

(require "structs.rkt")

; So hw4-test.rkt can access the functions.
(provide (all-defined-out))
(provide (all-from-out "structs.rkt"))


; Struct definition for Exercise 1.
(struct tile (letter value square))

(define (word-total-tr) null)

(define (number-in-month-tr) null)

(define (file-size-total-tr) null)


; Constructs a stream that produces values that are powers of two starting with two.
; Used to test stream-for-n-steps and stream-add-zero.
;
; @return A stream of the powers of two.
(define powers-of-two
  (letrec
      ; Returns a pair containing the next number in the powers of two and a thunk
      ; that can generate subsequent numbers in the powers of two.
      ;
      ; @param  num The next powers of two number.
      ; @return A pair containing a number and a thunk.
      ([next-thunk (lambda (num)
                     (cons
                      num
                      (lambda () (next-thunk (* num 2)))))])
    (lambda () (next-thunk 2))))

(define (stream-for-n-steps) null)

(define funky-stream null)

(define this-then-that null)

(define stream-add-zero null)
