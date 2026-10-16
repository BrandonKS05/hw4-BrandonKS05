#### CS 3270 – Programming Languages

# Homework 4

## Learning objectives

To gain more experience with the Racket language.

## Exam preparation

The exercises in this assignment provide practice for the following skills that will be tested in Exam 3:

* Tail recursive solutions (no. 1, 2, and 3).
* Creating streams using thunks (no. 5, 6, and 7).
* Accessing stream values (no. 4).

## GitHub notes

Please see [GitHub notes](github-notes.md) for more information on cloning, committing, and pushing repositories.

## Resources

You have been provided with two Racket files in the **src** folder:

* `hw4.rkt`: the file where you will write your functions.
* `hw4-test.rkt`: the file that contains the tests for each exercise.
* `structs.rkt`: the file that contains struct definitions for one of the exercises.

**Note: all the functions that you are tasked to write can be implemented using a combination of pre-defined Racket functions that were introduced in class.**

As with Homework 3, all the solutions should be written in a ***functional (non-destructive)*** fashion. You are also prohibited from using any *loop* constructs in Racket. Any solution must be recursive in nature.

## Style guidelines

* **Names:** Use proper style for names. The naming convention in Racket is to separate multi-word names with dashes. For example, a name that is bound to a list of months could be called `month-list` and a function that checks the validity of a value could be called `is-valid`. Also, use meaningful identifier names. For example, a variable that stores a speed value should be called `speed` instead of just `s`.

* **Line lengths:** No lines should exceed 100 columns.

* **Indentation:** Use proper and consistent indentation. DrRacket can help you with indentation, select **Racket | Reindent All** to reindent the entire file, or **Racket | Reindent** to reindent the selected lines of code.

* **Whitespace:** Functions should be separated by at least one empty line.

* **Global variables:** Prohibited. However, global constant variables are allowed.

* **Function definitions:** Functions must be defined using either `define` or `letrec`. Function definitions passed as an argument to another function can be defined using `lambda`.

* **Function header comments:** Use Javadoc-style comments to document all functions that you defined. This includes functions defined in other functions (i.e., nested functions). The only exception is if a function only has one nested function defined in it. In this case, only a single header is needed, but the comments in that header must describe both functions.

  For your reference, below is an example of Javadoc-style comments for a function.

   ```
  ; Returns an Image object that can then be painted on the screen.
  ;
  ; @param  url  An absolute URL giving the base location of the image.
  ; @param  name The location of the image, relative to the url argument.
  ; @return The image at the specified URL.
  ```

* **Ending parentheses:** Do not place ending parentheses on a line of their own. Place them at the end of the last line containing code.

## Note on commenting

***Do not*** use the commenting option on DrRacket called **Comment Out with a Box** (under **Racket**). If you need to comment out multiple lines, use multiple single line `;` comments or the **Comment Out with Semicolons** option instead.

## Exercises

In exercises 1–3, you will implement recursive solutions in a tail-recursive manner.

1. Write a *tail-recursive* function called `word-total-tr`, which should be a re-write of the `word-total` function (Problem 4 of Homework 3) and `word-total-mr` function (Problem 9 of Homework 3). Do not use a default value parameter, but rather define a helper function as described in class.

   ```Scheme
   > (word-total-tr (list (tile 'A 1 'none) (tile 'B 3 'none) (tile 'C 3 'none)))
   7

   > (word-total-tr (list (tile 'A 1 'tl) (tile 'B 3 'dl) (tile 'C 3 'none)))
   12

   > (word-total-tr (list (tile 'V 4 'tl) (tile 'A 1 'none) (tile 'N 1 'none)
                          (tile 'D 2 'none) (tile 'E 1 'tl) (tile 'R 1 'none)
                          (tile 'B 3 'none) (tile 'I 1 'none) (tile 'L 1 'tl)
                          (tile 'T 1 'none)))
   28
   ```

2. Write a *tail-recursive* function called `number-in-month-tr`, which should be a re-write of the `number-in-month` function (Problem 7 of Homework 3) and `number-in-month-mr` function (Problem 10 of Homework 3). Do not use a default value parameter, but rather define a helper function as described in class.

    ```Scheme
    > (number-in-month-tr '((2015 3 15) (2016 1 1) (2016 3 1) (2016 2 17)) 3)
    2

    > (number-in-month-tr '((2015 3 15) (2016 1 1) (2016 3 1) (2016 2 17)) 1)
    1

    > (number-in-month-tr '((2015 3 15) (2016 1 1) (2016 3 1) (2016 2 17)) 6)
    0
    ```

3. Consider two structs called **file** and **folder**. The **file** struct consists of the fields **name** and **size**. The **folder** struct consists of the fields **name** and **contents**. You can see the definition of these two structs in the [structs.rkt](src/structs.rkt) file on lines 11 and 12. The **contents** field in the **folder** struct will contain a list. This list will be a collection of files and folders.

   Write a *tail-recursive* function called `file-size-total-tr` that returns the total of all file sizes represented in the file system. The parameters `root-files-only`, `repository`, and `nested-folders` that are used in the example calls below are defined in the [structs.rkt](src/structs.rkt) file. For example, the `root-files-only` file system (defined on lines 29–31) consists of the `.gitignore` file (size: 1), the `github-notes.md` file (size: 4), and the `readme.md` file (size: 10). The struct instances for these files are defined in lines 15–17.

    ```Scheme
    > (file-size-total-tr root-files-only)
    15

    > (file-size-total-tr repository)
    24

    > (file-size-total-tr nested-folders)
    96
    ```

Exercises 4–7 explore *thunks* and *streams*. This is ***not*** an assignment about using the `stream` functions that are built into Racket. Rather you are to complete this assignment using only `car`, `cdr`, `cons`, `lambda`, and other Racket functions that were described in class.

4. Write a function called `stream-for-n-steps` that takes a stream and a non-negative integer. It returns a list holding values produced by the stream in order starting from the first value of the stream. The second parameter of the function (i.e., the non-negative integer) specifies the number of values that should be in the list. Note: you can use this function to test the streams you will produce in the following problems. Also, consider the `stream-nth` function described in class.

   ```Scheme
   > (stream-for-n-steps powers-of-two 0)
   '()

   > (stream-for-n-steps powers-of-two 1)
   '(2)

   > (stream-for-n-steps powers-of-two 5)
   '(2 4 8 16 32)

   > (stream-for-n-steps powers-of-two 10)
   '(2 4 8 16 32 64 128 256 512 1024)
   ```

5. Write a stream called `funky-stream` that is like the stream of natural numbers (i.e., 1, 2, 3, ...) except numbers divisible by 5 are negated (i.e., 1, 2, 3, 4, -5, 6, 7, 8, 9, -10, 11, ...). Remember a stream is a thunk that when called produces a pair. In this case the `car` of the pair will be a number and the `cdr` will be another stream. The built-in Racket function `modulo` or `remainder` performs modulo division.

   ```Scheme
   > (stream-for-n-steps funky-stream 1)
   '(1)

   > (stream-for-n-steps funky-stream 5)
   '(1 2 3 4 -5)

   > (stream-for-n-steps funky-stream 10)
   '(1 2 3 4 -5 6 7 8 9 -10)
   ```

6. Write a stream called `this-then-that`, where the elements of the stream alternate between the strings "If this" and "Then that" (starting with "If this"). One way to think of this problem is a thunk that when called produces a pair of "If this" and a thunk that when called produces a pair of "Then that" and a thunk that when called, and so on. Sample solution: four lines. Note: you can type the strings `"If this"` and `"Then that"` in your code (with the double quotes).

   ```Scheme
   > (stream-for-n-steps this-then-that 1)
   '("If this")

   > (stream-for-n-steps this-then-that 5)
   '("If this" "Then that" "If this" "Then that" "If this")

   > (stream-for-n-steps this-then-that 10)
   '("If this"
     "Then that"
     "If this"
     "Then that"
     "If this"
     "Then that"
     "If this"
     "Then that"
     "If this"
     "Then that")
   ```

7. Write a function called `stream-add-zero` that takes a stream `strm` and returns another stream. If `strm` would produce `x` for its *i-th* element, then `(stream-add-zero strm)` would produce the dotted pair `(0 . x)` for its *i-th* element. Sample solution: four lines. Hint: Use a thunk that when called uses `strm` and recursion.

   ```Scheme
   > (stream-for-n-steps (stream-add-zero powers-of-two) 1) ; Assuming powers-of-two is defined.
   '((0 . 2))

   > (stream-for-n-steps (stream-add-zero funky-stream) 5) ; Assuming funky-stream is defined.
   '((0 . 1) (0 . 2) (0 . 3) (0 . 4) (0 . -5))

   > (stream-for-n-steps (stream-add-zero powers-of-two) 10)
   '((0 . 2)
     (0 . 4)
     (0 . 8)
     (0 . 16)
     (0 . 32)
     (0 . 64)
     (0 . 128)
     (0 . 256)
     (0 . 512)
     (0 . 1024))
   ```

## Final notes

* You must **only** update the `hw4.rkt` file. **Do not** alter any other files!

* Ensure that your **name** and **email address** appear as header comments at the top of the `hw4.rkt` file.

* Submissions for this assignment will be run on **additional** hidden test cases during grading.

* You must **push** your repository containing all relevant files for this assignment to GitHub.com **before** the deadline to avoid a late penalty.

* A push to GitHub will automatically **trigger** a build with test cases. All builds **must pass** for the submission to be considered for full credit.

* Your score for this assignment will be available on Gradescope. Your submission will be transferred to Gradescope (from GitHub) by the course staff. You **do not** need to submit your work on Gradescope. Submissions are only accepted on GitHub.

* By submitting this assignment, you **attest** that you have neither given nor received unauthorized aid.

## AI usage

Using AI on this assignment is your choice, but these exercises are practice for the exam where you will be expected to know how to implement Racket functions.
