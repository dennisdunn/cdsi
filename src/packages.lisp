(in-package :cl-user)

(defpackage :cl-cdsi/calendar
  (:use :cl
        :cl-ppcre)
  (:export :date
           :interval
           :->keyword
           :parse
           :date+
           :date=
           :date<
           :date<=
           :date>
           :date>=))

(defpackage :cl-cdsi/supporting-data
  (:use :cl)
  (:export))

(defpackage :cl-cdsi/ehr-interface
  (:use :cl
        :cl-cdsi/calendar)
  (:export :patient
           :patient-dob
           :patient-gender
           :patient-assessment
           :patient-doses
           :dose
           :dose-number
           :dose-date-administered
           :dose-vaccine-name
           :dose-cvx
           :dose-mvx
           :dose-evaluation-status
           :dose-evaluation-reason
           :get-patient-info))

(defpackage :cl-cdsi
  (:use :cl
        :cl-cdsi/calendar
        :cl-cdsi/ehr-interface
        :cl-cdsi/supporting-data))
