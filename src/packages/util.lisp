(in-package :cl-user)

(defpackage :cdsi.util
  (:use :cl)
  (:export :parse-bool
           :flatten
           :with-nil-handler
           :get-value
           :get-string-value
           :get-integer-value
           :get-date-value
           :get-age-value
           :get-bool-value
           :get-keyword-value))

(in-package :cdsi.util)

;;;; Parsers

(defun parse-bool (x)
  (not (or (null x)
           (equal 0 x)
           (equal "" x)
           (equal "F" (format nil "~:@(~a~)" x))
           (equal "FALSE" (format nil "~:@(~a~)" x)))))

;;;; Sequence helpers

(defun flatten (lst)
  "Flatten the list lst
   https://stackoverflow.com/questions/49780045/lisp-list-linearization-with-map"
  (cond ((null lst) nil)
        ((atom lst) (list lst))
        (t (loop for e in lst appending (flatten e)))))

;;;; If handle-case catches a condition then simply return nil. Dangerous? Yeah. 

(defmacro with-nil-handler (&rest body)
  "Evaluate the body and return nil iff a condition occurs."
  `(handler-case (progn ,@body) (error nil)))

;;;; Xml helpers

(defun get-value (parser node tag)
  "Try to parse the child node and return a value or nil if the parser fails."
  (with-nil-handler
    (funcall parser (car (xmls:xmlrep-children (xmls:xmlrep-find-child-tag tag node))))))

(defun get-string-value (node tag)
  (get-value #'identity node tag))

(defun get-integer-value (node tag)
  (get-value #'parse-integer node tag))

(defun get-bool-value (node tag)
  (get-value #'parse-bool node tag))

(defun get-keyword-value (node tag)
  (get-value #'cdsi.calendar:parse-keyword node tag))

(defun get-date-value (node tag)
  (get-value #'cdsi.calendar:parse-date node tag))

(defun get-age-value (node tag)
  (get-value #'cdsi.calendar:parse-interval node tag))
