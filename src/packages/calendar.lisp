(in-package :cl-user)

(defpackage :cdsi.calendar
  (:use :cl)
  (:export :date
           :date-year
           :date-month
           :date-day
           :interval
           :interval-unit
           :interval-value
           :parse-date
           :parse-interval
           :parse-keyword
           :parse
           :date+
           :date=
           :date<
           :date<=
           :date>
           :date>=))

(in-package :cdsi.calendar)

(defstruct (date (:conc-name nil) (:constructor make-date (year month day)))
  year month day)

(defstruct (interval (:conc-name nil) (:constructor make-interval (value unit)))
  value unit)

(defparameter +seconds-in-a-day+ (* 60 60 24))
(defparameter +timezone+ 0) ; All dates are in the UTC timezone for calculation purposes.

;;;; Parsing

;;;; Parse dates "MM/DD/YYYY"

(defun parse-date (s)
  "Parse a date of the form 'MM/DD/YYYY'"
  (let* ((parts (ppcre:split "/" s))
         (date-parts (mapcar #'parse-integer parts)))
    (make-date (third date-parts) (first date-parts) (second date-parts))))

;;;; Parse intrvals "1 year - 4 days"

(defun parse-interval (s)
  "Return a list of intervals parsed from the string."
  (if (or (string= "" s) (null s))
      nil
      (let ((str2 (ppcre:regex-replace-all "[sS\\s]" s ""))
            result)
        (ppcre:do-register-groups ((#'parse-integer value) (#'parse-keyword unit))
                                  ("([+-]?\\d+)(\\w+)" str2)
                                  (push (make-interval value unit) result))
        (nreverse result))))

;;;; Intern a string or symbol in the KEYWORD package.
(defun parse-keyword (s)
  (if (symbolp s)
      (intern (symbol-name s) :keyword)
      (intern (string-upcase (string s)) :keyword)))

;;;; Date arithmetic

(defun date+ (dt int)
  "Add the interval to the date. If the interval is nil then just return the date."
  (if (interval-p int)
      (let ((u (unit int))
            (v (value int)))
        (cond ((eq u :year) (year+ dt v))
              ((eq u :month) (month+ dt v))
              ((eq u :week) (week+ dt v))
              ((eq u :day) (day+ dt v))))
      (reduce #'date+ int :initial-value dt)))

(defun year+ (dt v)
  (normalize (make-date (+ (year dt) v) (month dt) (day dt))))

(defun month+ (dt v)
  (let ((y (year dt))
        (m (+ (month dt) v))
        (d (day dt)))
    (multiple-value-bind (delta-y new-m) (floor m 12)
      (normalize (make-date (+ y delta-y) new-m d)))))

(defun week+ (dt v) (day+ dt (* 7 v)))

(defun day+ (dt v)
  (as-date (+ (as-timestamp dt) (* v +seconds-in-a-day+))))

;;;; Date comparers

(defun date= (a b)
  (= (as-timestamp a) (as-timestamp b)))

(defun date< (a b)
  (< (as-timestamp a) (as-timestamp b)))

(defun date> (a b)
  (> (as-timestamp a) (as-timestamp b)))

(defun date<= (a b)
  (not (date> a b)))

(defun date>= (a b)
  (not (date< a b)))

;;;; Misc

(defun as-timestamp (dt)
  (encode-universal-time 0 0 0 (day dt) (month dt) (year dt) +timezone+))

(defun as-date (ts)
  (multiple-value-bind (s min h d m y) (decode-universal-time ts +timezone+)
    (declare (ignore s min h))
    (make-date y m d)))

(defun normalize (dt)
  (as-date (as-timestamp dt)))
