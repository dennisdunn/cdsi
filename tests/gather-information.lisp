(in-package :cl-user)

(defpackage :cdsi/tests/gather-information
  (:use :cl
        :fiveam
        :cdsi/core
        :cdsi/core/calendar
        :cdsi/processing-model/gather-information))

(in-package :cdsi/tests/gather-information)

(def-suite* gather-information :in cdsi/tests::cdsi) ; how do you export a suite from a package?

(defparameter *patient-id* "2013-0004")
(defparameter *assessment-date* "10/19/2022")

(test create-patient-runtime-data-bag
      (let* ((data (make-runtime-data *patient-id* *assessment-date*))
             (patient (getv data :patient)))
        (is (date= (parse-date *assessment-date*) (getv data :assessment-date)))
        (is (string= "F" (getv patient :gender)))))