(in-package :cl-user)

(defpackage :cdsi.patient
  (:use :cl
        :cdsi.util
        :cdsi.calendar)
  (:export :patient
           :patient-p
           :patient-dob
           :patient-gender
           :patient-assement-date
           :patient-doses
           :get-patient
           :dose
           :dose-p
           :dose-number
           :dose-date-administered
           :dose-vaccine-name
           :dose-cvx
           :dose-mvx))

(in-package :cdsi.patient)

(defstruct patient
  dob
  gender
  assessment-date
  doses)

(defstruct dose
  number
  date-administered
  vaccine-name
  cvx
  mvx)

(defgeneric get-patient (id)
  (:documentation "When using cdsi.cases as the source, fetch the patient information from the testcase identified by the id."))

(defmethod get-patient ((id string))
  (let* ((record (cdsi.cases:get-case id))
         (patient (cdsi.cases:testcase-patient record))
         (doses (cdsi.cases:testcase-doses record)))
    (as-patient patient doses)))

(defmethod get-patient ((id number))
  (get-patient (multiple-value-bind (prefix num) (floor id 10000)
                 (format nil "~4,'0d-~4,'0d" prefix num))))

(defun as-patient (patient doses)
  (make-patient :dob (parse-date (cdsi.cases:patient-dob patient))
                :gender (parse-keyword (cdsi.cases:patient-gender patient))
                :assessment-date (parse-date (cdsi.cases:patient-assessment patient))
                :doses (mapcar #'as-dose doses)))

(defun as-dose (dose)
  (make-dose :number (parse-integer (cdsi.cases:dose-number dose))
             :date-administered (parse-date (cdsi.cases:dose-date-administered dose))
             :vaccine-name (cdsi.cases:dose-vaccine-name dose)
             :cvx (parse-integer (cdsi.cases:dose-cvx dose))
             :mvx (cdsi.cases:dose-mvx dose)))
