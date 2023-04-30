
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
  (encode-universal-time 0 0 0 (day dt) (month dt) (year dt) +timezone+))

(defun ->date (ts)
  (multiple-value-bind (s min h d m y) (decode-universal-time ts +timezone+)
    (declare (ignore s min h))
    (make-date y m d)))

(defun normalize (dt)
  (->date (->timestamp dt)))
