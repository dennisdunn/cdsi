(in-package :cl-user)

(defpackage :cdsi.util
  (:use :cl)
  (:export :as-keyword
           :parse-bool
           :flatten))

(defpackage :cdsi.calendar
  (:use :cl
        :cdsi.util)
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

(defpackage :cdsi.schedule
  (:use :cl
        :cdsi.util
        :cdsi.calendar)
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

(defpackage :cdsi.ehr
  (:use :cl
        :cdsi.util
        :cdsi.calendar)
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

(defpackage :cdsi
  (:use :cl
        :cdsi.util
        :cdsi.calendar
        :cdsi.ehr
        :cdsi.schedule)
  (:export :as-antigen-doses
           :antigen-dose-p
           :antigen-dose-evaluation-status))
