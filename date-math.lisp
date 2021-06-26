;;;; date.lisp

;;;; It turns out that to implement the CDC calcdate process (jump-to-first-of-next-month)
;;;; on top of the local-time process (jump-to-last-day-of-current-month) is a matter
;;;; of checking two conditons and adjusting accordingly.

(in-package :date-math)

(defparameter *min-date* (local-time:encode-timestamp 0 0 0 0 1 1 1900))
(defparameter *max-date* (local-time:encode-timestamp 0 0 0 0 31 12 2999))

(defun apply-intervals (date intervals &optional default)
  (if (and (null intervals) (not (null default)))
      default
      (reduce #'date+ intervals :initial-value date)))

(defun date+ (date interval)
  (let ((amount (getf interval :amount))
        (unit (getf interval :unit)))
    (cond ((eq unit :year) (add-years date amount))
          ((eq unit :month) (add-months date amount))
          ((eq unit :week) (add-days date (* amount 7)))
          (t (add-days date amount)))))

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
