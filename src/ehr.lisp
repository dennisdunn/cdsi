(in-package :cdsi.ehr)

(defstruct patient
  dob
  gender
  assessment
  doses)

(defstruct dose
  number
  date-administered
  vaccine-name
  cvx
  mvx)

(defun get-patient (id)
  "When using cdsi.cases as the source, fetch the patient information from the testcase identified by the id."
  (let* ((record (cdsi.cases:get-case (as-string id)))
         (patient (cdsi.cases:testcase-patient record))
         (doses (cdsi.cases:testcase-doses record)))
    (as-patient patient doses)))

(defun as-patient (patient doses)
  (make-patient :dob (parse-date (cdsi.cases:patient-dob patient))
                :gender (as-keyword (cdsi.cases:patient-gender patient))
                :assessment (parse-date (cdsi.cases:patient-assessment patient))
                :doses (mapcar #'as-dose doses)))

(defun as-dose (dose)
  (make-dose :number (parse-integer (cdsi.cases:dose-number dose))
             :date-administered (parse-date (cdsi.cases:dose-date-administered dose))
             :vaccine-name (cdsi.cases:dose-vaccine-name dose)
             :cvx (parse-integer (cdsi.cases:dose-cvx dose))
             :mvx (cdsi.cases:dose-mvx dose)))

(defgeneric as-string (id)
  (:documentation "Return the id in the form expected by the case library."))

(defmethod as-string ((id number))
  (multiple-value-bind (prefix num) (floor id 10000)
    (format nil "~4,'0d-~4,'0d" prefix num)))

(defmethod as-string ((id string))
  id)
