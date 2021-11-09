(in-package #:cl-cdsi/tests)

(def-suite support-tests
           :description "Test the supporting data functions."
           :in all-tests)

(in-suite support-tests)

(test find-specific-testcase
      (let ((tc (s::testcase "2013-0001")))
        (is (string= (u:node-text (u:node-path tc 'cdcTestId)) "2013-0001"))))

