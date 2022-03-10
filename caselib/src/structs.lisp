(in-package :caselib)

(defstruct catalog
  id
  name
  text)

(defstruct testcase
  id
  name
  text
  evaluation
  forecast
  patient
  doses) 

(defstruct evaluation)

(defstruct forecast)

(defstruct patient 
  dob
  gender
  assessment)

(defstruct dose 
  number
  date-administered
  vaccine-name
  cvx
  mvx
  evaluation-status
  evaluation-reason)
 
