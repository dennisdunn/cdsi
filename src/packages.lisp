(in-package :cl-user)

(defpackage :cl-cdsi/util
  (:nicknames :util)
  (:use :cl)
  (:export :as-keyword
           :parse-bool
           :get-string-value
           :get-integer-value
           :get-bool-value
           :get-date-value
           :get-age-value
           :flatten))

(defpackage :cl-cdsi/calendar
  (:nicknames :calendar)
  (:use :cl
        :util)
  (:export :date
           :interval
           :parse-date
           :parse-interval
           :parse
           :date+
           :date=
           :date<
           :date<=
           :date>
           :date>=))

(defpackage :cl-cdsi/support-interface
  (:nicknames :schedule)
  (:use :cl
        :util)
  (:export :vaccine
           :association
           :antigen-dose
           :get-vaccine
           :get-vaccine-antigens
           :vaccine-cvx
           :vaccine-description
           :vaccine-associations
           :association-antigen
           :association-begin-age
           :association-end-age))

(defpackage :cl-cdsi/ehr-interface
  (:nicknames :ehr)
  (:use :cl
        :util
        :calendar)
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
           :get-patient))

(defpackage :cl-cdsi
  (:nicknames :cdsi)
  (:use :cl
        :util
        :calendar
        :ehr
        :schedule))
