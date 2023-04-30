(in-package :cl-user)

(defpackage :cdsi/tests/calendar
  (:use :cl
        :cdsi.calendar
        :cdsi.lib
        :rove))

(defpackage :cdsi/tests/patient
  (:use :cl
        :cdsi.patient
        :rove))

(defpackage :cdsi/tests/schedule
  (:use :cl
        :cdsi.vaccine
        :cdsi.antigen
        :rove))
