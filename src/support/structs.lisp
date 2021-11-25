(defstruct patient 
  dob
  gender
  med-history)

(defstruct med-history
  text
  code
  code-sys)

(defstruct dose 
  number
  date-administered
  vaccine-name
  cvx
  mvx
  evaluationn-status
  evaluation-reason)

(defstruct test-info
  cdc-test-id
  test-case-name
  description)

(defstruct assessment
  date)


