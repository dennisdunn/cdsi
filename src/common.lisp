(in-package :cl-user)

(defpackage :cdsi.common
  (:use :cl)
  (:export :->keyword
           :get-property
           :set-property))

(in-package :cdsi.common)

(defun ->keyword (s)
  "Intern a string or symbol in the KEYWORD package."
  (intern (string-right-trim "S" (string-upcase (string s))) :keyword))

(defun get-property (key alist)
  "Get the value associated with the key."
  (cdr (assoc key alist)))

(defun set-property (key alist value)
  "Set the value associated with the key."
  (setf (cdr (assoc key alist)) value))
