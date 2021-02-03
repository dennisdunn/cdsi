;;;; date.lisp

;;;; It turns out that to implement the CDC calcdate process (jump-to-first-of-next-month)
;;;; on top of the local-time process (jump-to-last-day-of-current-month) is a matter
;;;; of checking two conditons and adjusting accordingly.

(in-package #:cl-cdsi-date)

(defparameter *interval-re* "[a-zA-Z]+|[-+]?\\d+")
(defparameter *invalid-chars* "[sS\\s]")

(defun parse-intervals (str)
  "Parse a string of the form '12 days - 4 months' into a list of plists."
  (let ((tokens (ppcre:all-matches-as-strings
		 *interval-re*
		 (ppcre:regex-replace-all *invalid-chars* str ""))))
    (loop :for (a b) :on tokens :by #'cddr
	  :while b
	  :collect (list :amount (parse-integer a)
			 :unit (intern (string-upcase b) "KEYWORD")))))

(defun apply-intervals (date intervals)
	       (reduce #'date+ intervals :initial-value date))

(defun date+ (date interval)
      (let ((amount (getf interval :amount))
	    (unit (getf interval :unit)))
	(cond ((eq unit :year) (add-years date amount))
	      ((eq unit :month) (add-months date amount))
	      ((eq unit :week) (add-days date (* amount 7)))
	      (t (add-days date amount)))))

(defun add-days (date amount)
  (adjust-timestamp date (offset :day amount)))

(defun add-months (date amount)
    (let ((result (adjust-timestamp date (offset :month amount))))
      (if  (> (timestamp-day date) (days-in-month (timestamp-month result) (timestamp-year result)))
	   (adjust-to-start-of-next-month result)
	   result)))

(defun add-years (date amount)
  (let ((result (adjust-timestamp date (offset :year amount))))
    (if (and (leap-day-p date) (not (leap-year-p result)))
	(adjust-to-start-of-next-month result)
	result)))

(defun adjust-to-start-of-next-month (date)
  (adjust-timestamp date (offset :month 1) (set :day-of-month 1)))

(defun leap-year-p (date)
  (eq 29 (days-in-month (timestamp-month date) (timestamp-year date))))

(defun leap-day-p (date)
  (and (eq 2 (timestamp-month date)) (eq 29 (timestamp-day date))))
