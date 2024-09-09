(in-package :cl-user)

(defpackage :cdsi.common
  (:use :cl
        :kebab)
  (:export :->keyword
           :get-property
           :set-property))

(in-package :cdsi.common)

(defun ->keyword (s &key (trim "S"))
  "Intern a string or symbol in the KEYWORD package."
  (intern (string-right-trim trim (string-upcase (kebab:to-kebab-case (string s)))) :keyword))

(defun get-property (key alist)
  "Get the value associated with the key."
  (cdr (assoc (->keyword key :trim nil) alist)))

(defun set-property (key alist value)
  "Set the value associated with the key."
  (setf (cdr (assoc (->keyword key :trim nil) alist)) value))
