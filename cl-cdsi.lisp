;;;; cl-cdsi.lisp

(in-package #:cl-cdsi)

(defun make-antigen-administered-doses (doses)
  "Take a list of vaccine administered doses and create an ordered list of antigen administered doses."
  (stable-sort (mapcan #'split-dose doses) #'string-lessp :key #'fourth))

(defun make-patient-series (series)
  "Make a patient series from an antigen series."
  (list :series-name (getf series :series-name)
	:series-type (name-to-keyword (getf series :series-type))
	:antigen (getf series :target-disease)
	:series-dose (series-doses (getf series :series-dose))
	:series-status nil))

(defun series-doses (doses)
  "Make a list of doses for the patient series from the doses in the antigen series."
  (mapcar (lambda (dose) (list :dose-number (name-to-keyword (getf dose :dose-number)) :is-valid nil)) doses))

(defun split-dose (dose)
  "Take a vaccine administered dose and create a list of antigen administered doses."
  (let* ((cvx (getf dose :cvx))
         (date (local-time:parse-timestring (getf dose :date-administered)))
         (antigens (fetch "vaccines" cvx "antigens")))
    (mapcar (lambda (antigen) (list :date-administered date :antigen antigen)) antigens)))
