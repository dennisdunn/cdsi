
(in-package :cl-cdsi)

(defstruct series 
  series-name
  target-disease
  vaccine-group
  series-admin-guidance
  series-type
  equivalent-series-groups
  required-gender
  doses)

(defstruct administered-dose
  cvx
  mvx
  vaccine-name
  lot-expiration
  condition
  date-administered)

(defstruct patient
  assessment-date
  dob
  gender
  med-history-code
  med-history-code-sys
  med-history-text
  observation-codes)
