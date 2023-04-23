(in-package :cl-cdsi/util)

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

;;;; Xml helpers

(defun get-value (parser node tag)
  (funcall parser (xmls:xmlrep-string-child (xmls:xmlrep-find-child-tag tag node) nil)))

(defun get-string-value (node tag)
  (get-value #'identity node tag))

(defun get-integer-value (node tag)
  (get-value #'parse-integer node tag))

(defun get-date-value (node tag)
  (get-value #'calendar:parse-date node tag))

(defun get-age-value (node tag)
  (get-value #'calendar:parse-interval node tag))

(defun get-bool-value (node tag)
  (get-value #'parse-bool node tag))
