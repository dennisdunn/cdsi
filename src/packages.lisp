(in-package :cl-user)

(defpackage :cdsi.calendar
  (:use :cl)
  (:export :date
           :make-date
           :date-year
           :date-month
           :date-day
           :interval
           :make-interval
           :interval-unit
           :interval-value
           :date+
           :date=
           :date<
           :date<=
           :date>
           :date>=))

(defpackage :cdsi.lib
  (:import-from :cdsi.calendar :make-date :make-interval)
  (:use :cl)
  (:export :parse-bool
           :parse-keyword
           :parse-date
           :parse-interval
           :flatten
           :with-nil-handler
           :get-string-value
           :get-integer-value
           :get-bool-value
           :get-keyword-value
           :get-date-value
           :get-interval-value))

(defpackage :cdsi.patient
  (:use :cl
        :cdsi.lib)
  (:export :patient
           :patient-id
           :patient-dob
           :patient-gender
           :patient-assement-date
           :patient-doses
           :dose-number
           :dose-date-administered
           :dose-vaccine-name
           :dose-cvx
           :dose-mvx))

(defpackage :cdsi.vaccine
  (:use :cl
        :cdsi.lib)
  (:export :vaccine
           :vaccine-cvx
           :vaccine-description
           :vaccine-associations
           :vaccine-antigens
           :association-antigen
           :association-begin-age
           :association-end-age))

(defpackage :cdsi.antigen
  (:use :cl
        :cdsi.lib)
  (:export :antigen
           :antigen-series
           :series-type
           :series-gender
           :series-indications
           :indication-observation-code
           :indication-description
           :indication-guidance
           :indication-begin-age
           :indication-end-age
           :observation-text
           :observation-code))
