(in-package :cl-user)

(defpackage :cdsi/tests
  (:use :cl
        :fiveam))

(in-package :cdsi/tests)

(def-suite* cdsi
           :description "Test the cdsi system.")
