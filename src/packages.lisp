(in-package :cl-user)

(defpackage :cl-cdsi/calendar
  (:use :cl
        :cl-ppcre)
  (:export date
           interval
           parse
           date+
           date=
           date<
           date<=
           date>
           date>=))

(defpackage :cl-cdsi/supporting-data
  (:use :cl)
  (:export))

(defpackage :cl-cdsi/ehr-interface
  (:use :cl)
  (:export :get-patient-info))

(defpackage :cl-cdsi
  (:use :cl
        :cl-cdsi/calendar
        :cl-cdsi/supporting-data))
