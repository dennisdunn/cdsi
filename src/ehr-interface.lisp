(in-package :cl-cdsi/ehr-interface)

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
  mvx
  evaluation-status
  evaluation-reason)

(defun get-patient-info (id)
  "When using cl-cdsi-cases as the source, fetch the patient information from the testcase identified by the id."
  (let* ((record (cl-cdsi-cases:get-case (id->string id)))
         (patient (cl-cdsi-cases:testcase-patient record))
         (doses (cl-cdsi-cases:testcase-doses record)))
    (->patient patient doses)))

(defun ->patient (patient doses)
  (make-patient :dob (parse (cl-cdsi-cases:patient-dob patient))
                :gender (->keyword (cl-cdsi-cases:patient-gender patient))
                :assessment (parse (cl-cdsi-cases:patient-assessment patient))
                :doses (mapcar #'->dose doses)))

(defun ->dose (dose)
  (make-dose :number (parse-integer (cl-cdsi-cases:dose-number dose))
             :date-administered (parse (cl-cdsi-cases:dose-date-administered dose))
             :vaccine-name (cl-cdsi-cases:dose-vaccine-name dose)
             :cvx (parse-integer (cl-cdsi-cases:dose-cvx dose))
             :mvx (cl-cdsi-cases:dose-mvx dose)
             :evaluation-status (->keyword (cl-cdsi-cases:dose-evaluation-status dose))
             :evaluation-reason (cl-cdsi-cases:dose-evaluation-reason dose)))

(defgeneric id->string (id)
  (:documentation "Return the id in the form expected by the case library."))

(defmethod id->string ((id number))
  (multiple-value-bind (prefix num) (floor id 10000)
    (format nil "~4,'0d-~4,'0d" prefix num)))

(defmethod id->string ((id string))
  id)
