(in-package :cl-cdsi/calendar)

(defstruct (date (:conc-name nil) (:constructor make-date (year month day)))
  year month day)

(defstruct (interval (:conc-name nil) (:constructor make-interval (value unit)))
  value unit)

(defparameter +seconds-in-a-day+ (* 60 60 24))
(defparameter +timezone+ 0) ; All times are in the UTC timezone

;;;; Parsing dates "MM/DD/YYYY"
;;;; Parsing intrvals "1 year - 4 days"

(defun parse (s)
  (if (> (ppcre:count-matches "[a-zA-Z]" s) 0)
      (parse-interval s)
      (parse-date s)))

(defun parse-date (s)
  "Parse a date of the form 'MM/DD/YYYY'"
  (let* ((parts (ppcre:split "/" s))
         (date-parts (mapcar #'parse-integer parts)))
    (make-date (third date-parts) (first date-parts) (second date-parts))))

(defun parse-interval (s)
  "Return a list of intervals parsed from the string."
  (let ((str2 (ppcre:regex-replace-all "[sS\\s]" s ""))
        result)
    (ppcre:do-register-groups ((#'parse-integer value) (#'->keyword unit))
      ("([+-]?\\d+)(\\w+)" str2)
      (push (make-interval value unit) result))
    (nreverse result)))

;;;; Date arithmetic

(defun date+ (dt int)
  (let ((u (unit int))
        (v (value int)))
    (cond ((eq u :year) (year+ dt v)))
    (cond ((eq u :month) (month+ dt v)))
    (cond ((eq u :week) (week+ dt v)))
    (cond ((eq u :day) (day+ dt v)))))

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
(defun ->keyword (s)
  (if (symbolp s)
      (intern (symbol-name s) :keyword)
      (intern (string-upcase (string s)) :keyword)))

(defun ->timestamp (dt)
  (encode-universal-time 0 0 0 (day dt) (month dt) (year dt) +timezone+))

(defun ->date (ts)
  (multiple-value-bind (s min h d m y) (decode-universal-time ts +timezone+)
    (declare (ignore s min h))
    (make-date y m d)))

(defun normalize (dt)
  (->date (->timestamp dt)))
