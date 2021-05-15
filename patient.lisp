
(in-package #:cl-cdsi)

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

