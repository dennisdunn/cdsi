
(in-package :cl-cdsi/support)

(defstruct patient
  dob
  gender
  observation-codes)

(defstruct assessment
  date
  patient
  history)

(defstruct vaccine-dose
  date
  name 
  cvx 
  mvx 
  evaluation-status
  evaluation-reason)


(defstruct testcase
  id
  name
  description
  series-status
  assessment-date
  patient
  vaccine-history
  forecast-num
  earliest-date
  recommended-date
  past-due-date
  vaccine-group
  evaluation-test-type
  forecast-test-type
  date-added
  date-updated
  reason-for-change
  changed-in-version)
