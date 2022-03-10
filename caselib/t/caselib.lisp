(in-package :caselib/tests)

(def-suite caselib-tests
           :description "Test the testcase library functions."
           :in all-tests)

(in-suite caselib-tests)

(test get-catalog
      (let ((ids (caselib:catalog))
            (is (= (length ids)) 823))))

(test find-specific-testcase
      (let ((tcase (caselib:load "2013-0001")))
        (is (string= (case-id tcase) "2013-0001"))))

