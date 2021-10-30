;;;; date.lisp

;;;; It turns out that to implement the CDC calcdate process (jump-to-first-of-next-month)
;;;; on top of the local-time process (jump-to-last-day-of-current-month) is a matter
;;;; of checking two conditons and adjusting accordingly.

(in-package :cl-cdsi/util)

(defparameter *min-date* (local-time:encode-timestamp 0 0 0 0 1 1 1900))
(defparameter *max-date* (local-time:encode-timestamp 0 0 0 0 31 12 2999))

(defun parse-and-adjust (intervalstring datestring)
  "Parse the intervals string and apply the results to the parsed date string."
  (let ((intervals (parse-intervals intervalstring))
	(date (parse-date datestring)))
    (adjust date intervals)))

(defun parse-date (datestring)
  "Parse a date of the form 'MM/DD/YYYY'"
  (let* ((parts (ppcre:split "/" datestring))
	 (date-parts (mapcar #'parse-integer parts)))
    (local-time:encode-timestamp 0 0 0 0 (second date-parts) (first date-parts) (third date-parts) :offset 0)))
  
(defun parse-intervals (intervalstring)
  "Return a list of intervals parsed from the string."
  (let ((str2 (ppcre:regex-replace-all "\\s+" intervalstring ""))
        result)
    (ppcre:do-register-groups ((#'parse-integer value) (#'name->keyword unit))
                              ("([+-]?\\d+)(\\w+)" str2)
                              (push `(:amount ,value :unit ,unit) result))
    (nreverse result)))

(defun adjust (date intervals &optional (default nil default-supplied-p))
  "Apply all of the intervals to the date."
  (cond ((and (null intervals) (eq default :min)) *min-date*)
        ((and (null intervals) (eq default :max)) *max-date*)
        ((and (null intervals) default-supplied-p) default)
        (t (reduce #'date+ intervals :initial-value date))))

(defun date+ (date interval)
  "Add the interval to the date."
  (let ((amount (getf interval :amount))
        (unit (getf interval :unit)))
    (cond ((year-p unit) (add-years date amount))
          ((month-p unit) (add-months date amount))
          ((week-p unit) (add-days date (* amount 7)))
          (t (add-days date amount)))))

(defun year-p (unit)
  (or (eq unit :year) (eq unit :years)))

(defun month-p (unit)
  (or (eq unit :month) (eq unit :months)))

(defun week-p (unit)
  (or (eq unit :week) (eq unit :weeks)))

(defun day-p (unit)
  (or (eq unit :day) (eq unit :days)))

(defun add-days (date amount)
  (local-time:adjust-timestamp date (offset :day amount)))

(defun add-months (date amount)
  (let ((result (local-time:adjust-timestamp date (offset :month amount))))
    (if (> (local-time:timestamp-day date) (local-time:days-in-month (local-time:timestamp-month result) (local-time:timestamp-year result)))
        (adjust-to-start-of-next-month result)
        result)))

(defun add-years (date amount)
  (let ((result (local-time:adjust-timestamp date (offset :year amount))))
    (if (and (leap-day-p date) (not (leap-year-p result)))
        (adjust-to-start-of-next-month result)
        result)))

(defun adjust-to-start-of-next-month (date)
  (local-time:adjust-timestamp date (offset :month 1) (set :day-of-month 1)))

(defun leap-year-p (date)
  (eq 29 (local-time:days-in-month (local-time:timestamp-month date) (local-time:timestamp-year date))))

(defun leap-day-p (date)
  (and (eq 2 (local-time:timestamp-month date)) (eq 29 (local-time:timestamp-day date))))
