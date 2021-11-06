;;;; packages.lisp

  (defpackage :cl-cdsi/support
    (:nicknames :db)
    (:use :cl
          :xmls
          :cl-ppcre
          :cl-cdsi/util)
    (:export :get-node 
             :antigen
             :antigen-keys
             :antigen-series
             :antigen-contraindications
             :antigen-immunity
             :series-type
             :series-indications
             :series-required-genders
             :indication-interval
             :make-assessment
             :assessment-date
             :assessment-patient
             :assessment-vaccine-doses
             :make-vaccine-dose
             :vaccine-dose-date
             :vaccine-dose-name
             :vaccine-dose-cvx
             :vaccine-dose-mvx
             :vaccine-dose-evaluation-status
             :vaccine-dose-evaluation-reason
             :make-patient
             :patient-dob
             :patient-gender
             :patient-observation-codes
             :testcase
             :make-testcase
             :testcase-id
             :testcase-name
             :testcase-description
             :testcase-assessment
             :testcase-patient
             :testcase-vaccine-history
             :testcase-assessment-date
             :testcase-series-status
             :testcase-forecast-num
             :testcase-earliest-date
             :testcase-recommended-date
             :testcase-past-due-date
             :testcase-vaccine-group
             :testcase-evaluation-test-type
             :testcase-forecast-test-type
             :testcase-date-added
             :testcase-date-updated
             :testcase-reason-for-change
             :testcase-changed-in-version))

