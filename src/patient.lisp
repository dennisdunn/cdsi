(in-package :cdsi.patient)

(defgeneric patient (id)
  (:documentation "When using cdsi.cases as the source, fetch the patient information from the testcase identified by the id."))

(defmethod patient ((id string))
  (cdsi.cases:get-case id))

(defmethod patient ((id number))
  (patient (multiple-value-bind (prefix num) (floor id 10000)
             (format nil "~4,'0d-~4,'0d" prefix num))))

(defun patient-id (obj)
  (cdsi.cases:patient-id obj))

(defun patient-dob (obj)
  (parse-date (cdsi.cases:patient-dob obj)))

(defun patient-gender (obj)
  (parse-keyword (cdsi.cases:patient-gender obj)))

(defun patient-assessment-date (obj)
  (parse-date (cdsi.cases:patient-assessment obj)))

(defun patient-doses (obj)
  (let* ((id (patient-id obj))
         (record (cdsi.cases:testcase-patient id)))
    (cdsi.cases:testcase-doses record)))

(defun dose-number (obj)
  (parse-integer (cdsi.cases:dose-number obj)))

(defun dose-date-administered (obj)
  (parse-date (cdsi.cases:dose-date-administered obj)))

(defun dose-vaccine-name (obj)
  (cdsi.cases:dose-vaccine-name obj))

(defun dose-cvx (obj)
  (parse-integer (cdsi.cases:dose-cvx obj)))

(defun dose-mvx (obj)
  (cdsi.cases:dose-mvx obj))
