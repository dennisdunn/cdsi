
(in-package :cdsi.calendar)

(defstruct date
  year month day)

(defstruct interval
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
  (normalize (make-date :year (+ (date-year dt) v) :month (date-month dt) :day (date-day dt))))

(defun month+ (dt v)
  (let ((y (date-year dt))
        (m (+ (date-month dt) v))
        (d (date-day dt)))
    (multiple-value-bind (delta-y new-m) (floor m 12)
      (normalize (make-date :year (+ y delta-y) :month new-m :day d)))))

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
    (make-date :year y :month m :day d)))

(defun normalize (dt)
  (->date (->timestamp dt)))

