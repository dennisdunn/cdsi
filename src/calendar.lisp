(in-package :cl-user)

(defpackage :cdsi.calendar
  (:import-from :cdsi.common #:->keyword)
  (:use :cl)
  (:export :date
           :make-date
           :parse-date
           :parse-interval
           :date-year
           :date-month
           :date-day
           :interval
           :make-interval
           :interval-unit
           :interval-value
           :date+
           :date=
           :date<
           :date<=
           :date>
           :date>=))

(in-package :cdsi.calendar)

(defstruct (date (:constructor make-date (year month day)))
  year month day)

(defstruct (interval (:constructor make-interval (value unit)))
  value unit)

(defparameter +seconds-in-a-day+ (* 60 60 24))
(defparameter +timezone+ 0) ; All dates are in the UTC timezone for calculation purposes.

;;;; Date arithmetic

(defun date+ (dt int)
  "Add the interval to the date. If the interval is nil then just return the date."
  (if (interval-p int)
      (let ((u (interval-unit int))
            (v (interval-value int)))
        (cond ((eq u :year) (year+ dt v))
              ((eq u :month) (month+ dt v))
              ((eq u :week) (week+ dt v))
              ((eq u :day) (day+ dt v))))
      (reduce #'date+ int :initial-value dt)))

(defun year+ (dt v)
  (normalize (make-date (+ (date-year dt) v) (date-month dt) (date-day dt))))

(defun month+ (dt v)
  (let ((y (date-year dt))
        (m (+ (date-month dt) v))
        (d (date-day dt)))
    (multiple-value-bind (delta-y new-m) (floor m 12)
      (normalize (make-date (+ y delta-y) new-m d)))))

(defun week+ (dt v) (day+ dt (* 7 v)))

(defun day+ (dt v)
  (->date (+ (->timestamp dt) (* v +seconds-in-a-day+))))

;;;; Date comparers

(defun date= (a b)
  (= (->timestamp a) (->timestamp b)))

(defun date< (a b)
  (< (->timestamp a) (->timestamp b)))

(defun date> (a b)
  (> (->timestamp a) (->timestamp b)))

(defun date<= (a b)
  (not (date> a b)))

(defun date>= (a b)
  (not (date< a b)))

;;;; Misc

(defun ->timestamp (dt)
  (encode-universal-time 0 0 0 (date-day dt) (date-month dt) (date-year dt) +timezone+))

(defun ->date (ts)
  (multiple-value-bind (s min h d m y) (decode-universal-time ts +timezone+)
    (declare (ignore s min h))
    (make-date y m d)))

(defun normalize (dt)
  (->date (->timestamp dt)))

;;;; Parse dates "MM/DD/YYYY"

(defun parse-date (s)
  "Parse a date of the form 'MM/DD/YYYY' or 'YYYY-MM-DDTHH:MM:SS'"
  (let* ((parts (ppcre:all-matches-as-strings "\\d+" s))
         (date-parts (mapcar #'parse-integer parts)))
    (if (= 3 (length date-parts))
        (make-date (third date-parts) (first date-parts) (second date-parts))
        (make-date (first date-parts) (second date-parts) (third date-parts)))))

;;;; Parse intrvals "1 year - 4 days"

(defun parse-interval (s)
  "Return a list of intervals parsed from the string."
  (if (or (string= "" s) (null s))
      nil
      (let ((str2 (ppcre:regex-replace-all "[sS\\s]" s ""))
            result)
        (ppcre:do-register-groups ((#'parse-integer value) (#'->keyword unit))
          ("([+-]?\\d+)(\\w+)" str2)
          (push (make-interval value unit) result))
        (nreverse result))))
