;;;; packages.lisp

(defpackage :date-math
  (:nicknames :dates)
  (:use :cl
        :cl-ppcre
        :local-time)
  (:export :parse-intervals
           :adjust
           :date+))

(defpackage :structs
  (:use :cl)
  (:export :make-assessment
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
           :make-testcase
           :testcase-id
           :testcase-name
           :testcase-description
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

(defpackage :util
  (:use :cl
        :date-math)
  (:export :name->keyword
           :node->string
           :node->intervals))

(defpackage :supporting-data
  (:nicknames :support)
  (:use :cl
        :xmls
        :util
        :cl-ppcre)
  (:export :antigen-keys
           :get-antigen
           :get-series
           :get-series-type
           :get-indications
           :get-required-genders
           :get-schedule))

(defpackage :select-patient-series
  (:use :cl
        :util
        :structs
        :date-math
        :supporting-data)
  (:export :series-standard-p
           :series-required-gender-p))

(defpackage :testcases
  (:use :cl
        :util
        :structs))

(defpackage :cl-cdsi
  (:nicknames :cdsi)
  (:use :cl))
