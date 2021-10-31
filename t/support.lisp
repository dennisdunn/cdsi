(in-package #:cl-cdsi/tests)

(def-suite support-tests
           :description "Test the supporting data functions."
           :in all-tests)

(in-suite support-tests)

(test read-supporting-data-headers
      (is (eq 63 (length (db::read-headers)))))

(test read-testcases
      (is (eq 823 (length (db::read-testcases)))))

(test find-specific-testcase
      (let ((tc (db::testcase "2013-0001")))
        (is (string= (db::testcase-id tc) "2013-0001"))))

