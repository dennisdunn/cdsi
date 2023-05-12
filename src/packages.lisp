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

(defpackage :parse
  (:use :cl))

(defpackage :cdsi.lib
  (:import-from :cdsi.calendar :make-date :make-interval)
  (:use :cl)
  (:export :parse-bool
           :parse-keyword
           :parse-date
           :parse-interval
           :with-nil-handler
           :get-string-value
           :get-integer-value
           :get-bool-value
           :get-keyword-value
           :get-date-value
           :get-interval-value))

(defpackage :cdsi.api
  (:use :cl)
  (:export :antigen-catalog
           :antigen
           :antigen-series
           :vaccine-catalog
           :vaccine
           :observation-catalog
           :observation
           :vaccine-group-catalog
           :case-catalog
           :case-item
           :case-medical))

(defpackage :cdsi
  (:use :cl
        :cdsi.calendar
        :cdsi.lib
        :cdsi.api))