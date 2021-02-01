;;;; date.lisp

(in-package #:cl-cdsi-date)

(defparameter *interval-re* "[a-zA-Z]+|[-+]?\\d+")
(defparameter *invalid-chars* "[sS\\s]")
(defparameter *date-re* "\\d{4}|\\d{2}")
(defparameter *date-invalid-chars* "T.*")

(defun lexer (token-re invalid-re str)
  (ppcre:all-matches-as-strings
		 token-re
		 (ppcre:regex-replace-all invalid-re str "")))

(defun parse-interval (str)
  (let ((tokens (lexer *interval-re* *invalid-chars* str)))
    (loop :for (a b) :on tokens :by #'cddr
	  :while b
	  :collect (list :amount (parse-integer a)
			 :unit (intern (string-upcase b) "KEYWORD")))))

(defun parse-date (str)
  "Split ISO8061 dates into year, month, day."
  (let* ((tokens (lexer *date-re* *date-invalid-chars* str))
	 (values (mapcar #'parse-integer tokens)))
    (list :year (first values) :month (second values) :day (third values))))

(defun make-date (year month day)
 (list :year year :month month :day day))

(defun is-leap-year (date)
  (let ((year (getf date :year)))
    (cond ((not (eq (rem year 4) 0)) nil)
	  ((not (eq (rem year 100) 0)) t)
	  ((not (eq (rem year 400) 0)) nil)
	  (t t))))

(defun days-in-month (date)
  (let ((month (getf date :month)))
    (nth (1- month) (list 31 (if (is-leap-year date) 29 28) 31 30 31 30 31 31 30 31 30 31))))

(defun is-valid (date)
  (<= (getf date :day) (days-in-month date)))

(defun field+ (date field)
  (setf (getf date field) (1+ (getf date field)))
  (fix-it date))

(defun fix-it (date)
  (let ((day  (getf date :day))
	(month (getf date :month))
	(year (getf date :year)))
    (if (> day (days-in-month date))
	(progn
	  (setf day 1)
	  (setf month (1+ month))))
    (if (= month 13)
	(progn
	  (setf month 1)
	  (setf year (1+ year))))
    (setf (getf date :day) day)
    (setf (getf date :month) month)
    (setf (getf date :year) year)
    date))
	
(defun date+ (date interval)
  (let ((field (getf interval :unit))
	(amt (getf interval :amount)))
    (dotimes (amt) (field+ date field))))
    
