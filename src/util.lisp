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
