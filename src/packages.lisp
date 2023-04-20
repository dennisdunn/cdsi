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

(defpackage :cl-cdsi
  (:use :cl
        :cl-cdsi/calendar))
