(in-package :cl-user)

(defpackage :cdsi.common
  (:use :cl
        :kebab)
  (:export :->keyword
           :getv
           :setv
           :fetch))

(in-package :cdsi.common)

(defun ->keyword (s &key (trim "S"))
  "Intern a string or symbol in the KEYWORD package."
  (intern (string-right-trim trim (string-upcase (kebab:to-kebab-case (string s)))) :keyword))

;;;; Association list helprs

(defun getv (alist key)
  "Get the value of the key from the alist."
  (cdr (assoc key alist)))

(defun setv (alist key value)
  "Set the value of the key from the alist."
  (push (cons key value) alist))

;;;; API access to the supporting data and test cases

(defparameter *url* "https://api.opencdsi.org/v2/")

(defun fetch (area key)
  "Get the item specified by area/key as an alist."
  (with-input-from-string (s (dex:get (format nil "~a~(~a~)/~(~a~)/" *url* area key)))
    (json:decode-json s)))
