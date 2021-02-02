;;;; date.lisp

(in-package #:cl-cdsi-date)

(defparameter *interval-re* "[a-zA-Z]+|[-+]?\\d+")
(defparameter *invalid-chars* "[sS\\s]")

(defun parse-interval (str)
  "Parse a string of the form '12 days - 4 months' into a plist."
  (let ((tokens (ppcre:all-matches-as-strings
		 *interval-re*
		 (ppcre:regex-replace-all *invalid-chars* str ""))))
    (loop :for (a b) :on tokens :by #'cddr
	  :while b
	  :collect (list :amount (parse-integer a)
			 :unit (intern (string-upcase b) "KEYWORD")))))

(defun date+ (date intervals)
  "Add each interval to the date and return the result. Note that this is not compliant with the CDC calcdate
decision tables as we move to the last day of previous month instead of the first day of the next month in the
event of an invalid date."
  (let ((result date))
    (dolist (interval intervals)
      (let ((amount (getf interval :amount))
	    (unit (getf interval :unit)))
	(setf result
	      (cond ((eq unit :week) (adjust-timestamp result (offset :day (* 7 amount))))
		    (t (progn (adjust-timestamp result (offset unit amount))))))))
    result))
