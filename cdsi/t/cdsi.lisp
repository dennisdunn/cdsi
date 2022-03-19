(in-package #:cdsi/tests)

(def-suite cdsi-tests
  :description "Test the evaluation/forecasting functions."
  :in all-tests)

(in-suite cdsi-tests)

(defparameter *testcase* (caselib:get-case "2013-0005"))

(test prepare-data
  "Prepare antigen records from vaccine records."
  (let ((records (cdsi:prepare-antigen-records (caselib:testcase-doses *testcase*))))
   (print  records)))