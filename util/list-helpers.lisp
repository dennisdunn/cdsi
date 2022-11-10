(in-package :cl-cdsi/util)

;;;; Thank you StackOverflow https://stackoverflow.com/questions/2680864/how-to-remove-nested-parentheses-in-lisp
(defun flatten (L)
"Converts a list to single level."
    (if (null L)
        nil
        (if (atom (first L))
            (cons (first L) (flatten (rest L)))
            (append (flatten (first L)) (flatten (rest L))))))
