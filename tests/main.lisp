
(in-package :cl-cdsi/tests)

;; NOTE: To run this test file, execute `(asdf:test-system :cdsi)' in your Lisp.

(def-suite all-tests
    :description "The master suite of all cdsi tests.")

(in-suite all-tests)

(test dummy-tests
  "Just a placeholder."
  (is (listp (list 1 2)))
  (is (= 5 (+ 2 3))))
