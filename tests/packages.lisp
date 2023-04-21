(in-package :cl-user)

(defpackage :cl-cdsi/tests/calendar
  (:use :cl
        :cl-cdsi/calendar
        :rove))

(defpackage :cl-cdsi/tests/ehr-interface
  (:use :cl
        :cl-cdsi/ehr-interface
        :rove))

(defpackage :cl-cdsi/tests/supporting-data
  (:use :cl
        :cl-cdsi/supporting-data
        :rove))
