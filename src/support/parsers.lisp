(in-package :support)

(defun parse-bool (x)
  (not (or (null x)
           (equal 0 x)
           (equal "" x)
           (equal "F" (format nil "~:@(~a~)" x))
           (equal "FALSE" (format nil "~:@(~a~)" x)))))

;;;; Intern a string or symbol in the KEYWORD package.
(defun parse-keyword (s)
  (intern (string-upcase (string s)) :keyword))
