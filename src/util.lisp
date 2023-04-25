(in-package :cdsi.util)

(defun as-keyword (s)
  (if (symbolp s)
      (intern (symbol-name s) :keyword)
      (intern (string-upcase (string s)) :keyword)))

(defun parse-bool (x)
  (not (or (equal "" x)
           (equal "FALSE" (format nil "~:@(~a~)" x))
           (equal "F" (format nil "~:@(~a~)" x))
           (equal 0 x)
           (null x))))


;;;; Sequence helpers

(defun flatten (lst)
  "Flatten the list lst
   https://stackoverflow.com/questions/49780045/lisp-list-linearization-with-map"
  (cond ((null lst) nil)
        ((atom lst) (list lst))
        (t (loop for e in lst appending (flatten e)))))
