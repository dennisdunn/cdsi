(in-package :cl-user)

(defpackage :cdsi/tests/calendar
  (:use :cl
        :cdsi.calendar
        :rove))

(defpackage :cdsi/tests/ehr
  (:use :cl
        :cdsi.ehr
        :rove))

(defpackage :cdsi/tests/schedule
  (:use :cl
        :cdsi.schedule
        :rove))

(defpackage :cdsi/tests/cdsi
  (:use :cl
        :cdsi.schedule
        :cdsi.calendar
        :cdsi.ehr
        :cdsi
        :rove))
