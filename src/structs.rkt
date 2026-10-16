#lang racket

; So hw4.rkt can access the definitions.
(provide root-files-only)
(provide repository)
(provide nested-folders)
(provide (struct-out file))
(provide (struct-out folder))

; Struct definitions for Exercise 3.
(struct file (name size))
(struct folder (name contents))

; Files.
(define gitignore (file ".gitignore" 1))
(define github-notes-md (file "github-notes.md" 4))
(define readme-md (file "readme.md" 10))
(define hw4-rkt (file "hw4.rkt" 2))
(define hw4-test-rkt (file "hw4-test.rkt" 6))
(define hw4-yml (file "hw4.yml" 1))

; `root-files-only` represents the following file system:
;
;    hw4/
;    |-- .gitignore
;    |-- github-notes.md
;    |-- readme.md
;
(define root-files-only
  (list
   (folder "hw4" (list gitignore github-notes-md readme-md))))

; `repository` represents the following file system:
;
;    hw4/
;    |-- .github/
;        |-- workflows/
;            |-- hw4.yml
;    |-- src/
;        |-- hw4.rkt
;        |-- hw4-test.rkt
;    |-- .gitignore
;    |-- github-notes.md
;    |-- readme.md
;
(define repository
  (list
   (folder "hw4" (list
                  (folder ".github" (list (folder "workflows" (list hw4-yml))))
                  (folder "src" (list hw4-rkt hw4-test-rkt))
                  gitignore
                  github-notes-md
                  readme-md))))

; Make a list of defined files.
(define all-files
  (list gitignore github-notes-md readme-md hw4-rkt hw4-test-rkt hw4-yml))

; `nested-folders` represents the following file system:
;
;    folder1/
;    |-- folder2/
;    |   |-- folder4/
;    |   |   |-- .gitignore
;    |   |   |-- github-notes.md
;    |   |   |-- readme.md
;    |   |   |-- hw4.rkt
;    |   |   |-- hw4-test.rkt
;    |   |   |-- hw4.yml
;    |   |-- .gitignore
;    |   |-- github-notes.md
;    |   |-- readme.md
;    |   |-- hw4.rkt
;    |   |-- hw4-test.rkt
;    |   |-- hw4.yml
;    |-- folder3/
;    |   |-- folder5/  (empty folder)
;    |   |-- .gitignore
;    |   |-- github-notes.md
;    |   |-- readme.md
;    |   |-- hw4.rkt
;    |   |-- hw4-test.rkt
;    |   |-- hw4.yml
;    |-- .gitignore
;    |-- github-notes.md
;    |-- readme.md
;    |-- hw4.rkt
;    |-- hw4-test.rkt
;    |-- hw4.yml
;
(define nested-folders
  (list
   (folder "folder1"
           (cons
            (folder "folder2"
                    (cons (folder "folder4" all-files) all-files))
            (cons
             (folder "folder3"
                     (cons (folder "folder5" null) all-files))
             all-files)))))
