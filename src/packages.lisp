(in-package :cl-user)

(defpackage :cl-cdsi/date-math
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
        :cl-cdsi/date-math))
