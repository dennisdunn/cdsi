(in-package :select-patient-series)

(defun series-standard-p (series)
  "Returns T if this is a standard series or nil for a risk series."
  (eq :STANDARD (support:get-series-type series)))

(defun series-required-gender-p (series gender)
  "Return T if the gender is one of the series required genders. 
  If the series required genders list is empty then the series applies to all genders."
  (let ((genders (support:get-required-genders series)))
    (or (null genders)
        (member gender genders))))

(defun indicated-p (indication assessment-date observation-codes dob)
  "Return T if this indication applies to the supplied arguments."
  (let* ((code (util:node->string 'code indication))
         (begin-age (util:node->intervals 'beginage indication))
         (end-age (util:node->intervals 'endage indication)))
    (and (member code observation-codes)
         (< (date-math:adjust dob begin-age :min) assessment-date (date-math:adjust dob end-age :max)))))

(defun any-indicated-p (indications assessment-date observation-codes dob)
  "Return T if any of the indications apply."
  (reduce (lambda (acc cur) (or acc cur)) (mapcar (lambda (x) (indicated-p x assessment-date observation-codes dob))) nil))

