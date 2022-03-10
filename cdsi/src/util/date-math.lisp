;;;; date.lisp

;;;; It turns out that to implement the CDC calcdate process (jump-to-first-of-next-month)
;;;; on top of the local-time process (jump-to-last-day-of-current-month) is a matter
;;;; of checking one conditon and adjusting accordingly.

;;;; local-time notes
;;;; (local-time:parse-timestring "2020-01-01") assumes UTC unless an ofset is provided.
;;;; (local-time:encode-timestamp 0 0 0 0 1 1 2020) assumes local-time:*default-timezone* unless provided.

(in-package :cl-cdsi/util)

(defparameter *min-date* (local-time:encode-timestamp 0 0 0 0 1 1 1900))
(defparameter *max-date* (local-time:encode-timestamp 0 0 0 0 31 12 2999))

(defun get-tz-offset ()
  "Get the offset of the default timezone."
  (local-time:timestamp-subtimezone (local-time:now) local-time:*default-timezone*))

(defun parse-and-adjust (intervalstring datestring)
  "Parse the intervals string and apply the results to the parsed date string."
  (let ((intervals (parse-intervals intervalstring))
        (date (parse-date datestring)))
    (adjust date intervals)))

(defun parse-date (datestring)
  "Parse a date of the form 'MM/DD/YYYY'"
  (let* ((parts (ppcre:split "/" datestring))
         (date-parts (mapcar #'parse-integer parts)))
    (local-time:encode-timestamp 0 0 0 0 (second date-parts) (first date-parts) (third date-parts))))

(defun parse-intervals (intervalstring)
  "Return a list of intervals parsed from the string."
  (let ((str2 (ppcre:regex-replace-all "[sS\\s]" intervalstring ""))
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
    (if (or (eq unit :year) (eq unit :month))
      (let* ((new (local-time:adjust-timestamp date (offset unit amount)))
             (dom0 (local-time:timestamp-day date))
             (dom1 (local-time:timestamp-day new)))
        (if (eq dom0 dom1)
          new
          (local-time:adjust-timestamp new (offset :day 1))))
      (progn (when (eq unit :week)
               (setf unit :day)
               (setf amount (* 7 amount)))
             (local-time:adjust-timestamp date (offset unit amount))))))

