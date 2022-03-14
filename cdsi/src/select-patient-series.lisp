(in-package :cdsi)

(defun series-standard-p (series)
  "Returns T if this is a standard series or nil for a risk series."
  (eq :STANDARD (series-type series)))

(defun series-required-gender-p (series gender)
  "Return T if the gender is one of the series required genders. 
  If the series required genders list is empty then the series applies to all genders."
  (let ((genders (series-required-genders series)))
    (or (null genders)
        (member gender genders))))

(defun indicated-p (indication assessment)
  "Return T if this indication applies to the supplied arguments."
  (let* ((code (node->string 'code indication))
         (begin-age (indication-interval 'beginage indication))
         (end-age (indication-interval 'endage indication))
	 (dob (parse-date (patient-dob (assessment-patient assessment)))))
    (and (member code observation-codes)
         (timestamp< (adjust dob begin-age :min) assessment-date (adjust dob end-age :max)))))

(defun any-indicated-p (indications assessment)
  "Return T if any of the indications apply."
  (some (mapcar (lambda (x) (indicated-p x assessment)) indications)))

