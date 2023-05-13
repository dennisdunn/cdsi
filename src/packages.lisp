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

(defpackage :cdsi.parse
  (:import-from :cdsi.calendar :make-date :make-interval)
  (:use :cl)
  (:export :parse))

(defpackage :cdsi.api
  (:use :cl)
  (:export :catalogs
           :antigen-catalog
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
        :cdsi.parse
        :cdsi.api))
