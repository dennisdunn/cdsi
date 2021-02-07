;;;; cl-cdsi.lisp

(in-package #:cl-cdsi)

(defun organize-immunization-history (doses)
  "Logic Spec Section 4.2
Take a list of vaccine administered doses and create an ordered list of antigen administered doses."
  (stable-sort (client::convert-values #'parse:as-keyword '(:antigen) (mapcan #'split-dose doses)) #'string-lessp :key #'fourth))

(defun select-relevant-patient-series (patient series)
  "Logic Spec Section 5.1
Return T iff this series is relevant for this assessment."
  (let ((gender (getf patient :gender))
	(options (getf series :required-gender))
	(series-type (getf series :series-type))
	(indications (getf series :indication)))
    (cond ((and (required-gender-p options gender) (eq series-type :standard)) series)
	  ((and (required-gender-p options gender) (indicated-p indications patient)) series)
	  (t nil))))
	  
(defun evaluate-dose-administered-condition (dose)
  "Logic Spec Section 6.1
Return T iff this vaccine administered dose can be evaluated."
  (if (and (not (getf dose :condition))
	   (local-time:timestamp< (getf dose :date-administered) (getf dose :lot-expiration date:*max-date*)))
      dose
      nil))

(defun evaluate-conditional-skip (dose)
  "Logic Spec Section 6.2"
  dose)

(defun required-gender-p (options gender)
  "Return T iff patient's gender is one of the required genders."
  (or (member gender options)
      (null options)))

(defun indicated-p (indications patient)
  "Return T iff at least one of the indications apply to the patient."
  (some (lambda (indication)
	  (let* ((code (getf (getf indication :observation-code) :code))
		 (dob (getf patient :dob))
		 (begin-age (date:apply-intervals dob (getf indication :begin-age) date:*min-date*))
		 (end-age (date:apply-intervals dob (getf indication :end-age) date:*max-date*)))
	    (and (member code (getf patient :observation-codes))
		 (local-time:timestamp< begin-age (getf (getf patient :patient) :assessment-date) end-age))))
	indications))
  
(defun series-doses (doses)
  "Make a list of doses for the patient series from the doses in the antigen series."
  (mapcar (lambda (dose) (list :dose-number (getf dose :dose-number) :is-valid nil)) doses))

(defun split-dose (dose)
  "Take a vaccine administered dose and create a list of antigen administered doses."
  (let* ((cvx (getf dose :cvx))
         (date (getf dose :date-administered))
         (antigens (fetch "vaccines" cvx "antigens")))
    (mapcar (lambda (antigen) (list :date-administered date :antigen antigen)) antigens)))
