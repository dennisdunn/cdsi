(in-package :cl-user)

(defpackage :cdsi/tests/calendar
  (:use :cl
        :cdsi.calendar
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

(defpackage :cdsi/tests/cdsi
  (:use :cl
        :cdsi.vaccine
        :cdsi.antigen
        :cdsi.calendar
        :cdsi.patient
        :cdsi.gather-data
        :cdsi
        :rove))
