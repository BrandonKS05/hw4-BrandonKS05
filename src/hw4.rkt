#lang racket

; Name: Brandon Lee
; Email: jin.woo.lee@vanderbilt.edu

(require "structs.rkt")

; So hw4-test.rkt can access the functions.
(provide (all-defined-out))
(provide (all-from-out "structs.rkt"))


; Struct definition for Exercise 1.
(struct tile (letter value square))

; Computes the score of a single tile based on its value and the square it was placed on.
;
; @param  current-tile A tile struct.
; @return The tile value tripled for 'tl, doubled for 'dl, or unchanged otherwise.
(define (tile-score current-tile)
  (case (tile-square current-tile)
    [(tl) (* 3 (tile-value current-tile))]
    [(dl) (* 2 (tile-value current-tile))]
    [else (tile-value current-tile)]))

; Computes the total value of a word made up of Scrabble tiles in a tail-recursive manner.
;
; @param  tiles A list of tile structs representing a word.
; @return The total value of the word.
(define (word-total-tr tiles)
  ; Accumulates the scores of the remaining tiles onto the running total.
  ;
  ; @param  remaining-tiles The tiles that have not been scored yet.
  ; @param  total           The combined score of the tiles processed so far.
  ; @return The total value of the word once no tiles remain.
  (define (word-total-helper remaining-tiles total)
    (if (null? remaining-tiles)
        total
        (word-total-helper (cdr remaining-tiles)
                           (+ total (tile-score (car remaining-tiles))))))
  (word-total-helper tiles 0))


; Counts how many dates fall in the given month in a tail-recursive manner.
;
; @param  dates A list of three-element dates (year month day).
; @param  month An integer representing a month.
; @return The number of dates in the list whose month equals month.
(define (number-in-month-tr dates month)
  ; Walks the remaining dates, incrementing the count for each one in the given month.
  ;
  ; @param  remaining-dates The dates that have not been examined yet.
  ; @param  count           The number of matching dates found so far.
  ; @return The number of matching dates once no dates remain.
  (define (number-in-month-helper remaining-dates count)
    (cond
      [(null? remaining-dates) count]
      [(= (second (car remaining-dates)) month)
       (number-in-month-helper (cdr remaining-dates) (+ count 1))]
      [else (number-in-month-helper (cdr remaining-dates) count)]))
  (number-in-month-helper dates 0))



; Computes the total size of every file in a file system in a tail-recursive manner.
;
; @param  file-system A list of file and folder structs, where folders may contain
;                     further files and folders.
; @return The sum of the sizes of all files in the file system.
(define (file-size-total-tr file-system)
  ; Processes a work list of files and folders. Files add their size to the running total,
  ; while the contents of folders are placed on the front of the work list to be processed.
  ;
  ; @param  remaining The files and folders that have not been processed yet.
  ; @param  total     The combined size of the files processed so far.
  ; @return The total file size once no files or folders remain.
  (define (file-size-helper remaining total)
    (cond
      [(null? remaining) total]
      [(file? (car remaining))
       (file-size-helper (cdr remaining) (+ total (file-size (car remaining))))]
      [(folder? (car remaining))
       (file-size-helper (append (folder-contents (car remaining)) (cdr remaining)) total)]
      [else (file-size-helper (cdr remaining) total)]))
  (file-size-helper (if (list? file-system) file-system (list file-system)) 0))


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

; Collects the first n values produced by a stream into a list.
;
; @param  strm A stream, which is a thunk that produces a pair of a value and another stream.
; @param  n    A non-negative integer giving the number of values to collect.
; @return A list of the first n values of the stream, in order.
(define (stream-for-n-steps strm n)
  (if (<= n 0)
      null
      (let ([next-pair (strm)])
        (cons (car next-pair) (stream-for-n-steps (cdr next-pair) (- n 1))))))


; Constructs a stream of the natural numbers starting with one, where every number divisible
; by five is negated.
;
; @return A stream of the natural numbers with multiples of five negated.
(define funky-stream
  (letrec
      ; Returns a pair containing the next number in the stream and a thunk that can
      ; generate subsequent numbers in the stream.
      ;
      ; @param  num The next natural number.
      ; @return A pair containing a number (negated if divisible by five) and a thunk.
      ([next-thunk (lambda (num)
                     (cons
                      (if (= (remainder num 5) 0) (- num) num)
                      (lambda () (next-thunk (+ num 1)))))])
    (lambda () (next-thunk 1))))


; Constructs a stream whose values alternate between the strings "If this" and "Then that",
; starting with "If this".
;
; @return A stream of alternating "If this" and "Then that" strings.
(define this-then-that
  (letrec
      ; Returns a pair containing "If this" and the thunk that produces "Then that" next.
      ;
      ; @return A pair containing "If this" and a thunk.
      ([this-thunk (lambda () (cons "If this" that-thunk))]
       ; Returns a pair containing "Then that" and the thunk that produces "If this" next.
       ;
       ; @return A pair containing "Then that" and a thunk.
       [that-thunk (lambda () (cons "Then that" this-thunk))])
    this-thunk))


; Constructs a stream that produces the values of the given stream, each paired with a zero.
;
; @param  strm A stream, which is a thunk that produces a pair of a value and another stream.
; @return A stream whose i-th value is the dotted pair (0 . x), where x is the i-th value
;         of strm.
(define (stream-add-zero strm)
  (lambda ()
    (let ([next-pair (strm)])
      (cons (cons 0 (car next-pair))))))
