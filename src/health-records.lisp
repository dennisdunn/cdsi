(in-package :cl-user)

(defpackage :cdsi.health-records
  (:nicknames :hr)
  (:use :cl
        :cdsi.common)
  (:export :patient
           :patient-doses
           :patient-gender))

(in-package :cdsi.health-records)

(defun patient (key)
  "Get the specified patient."
  (getv (fetch 'cases key) :patient))

(defun patient-doses (patient)
  (let ((doses (getv patient :doses))
        (idx 0))
    (mapcar #'(lambda (dose) (acons :number (incf idx) dose)) doses)))