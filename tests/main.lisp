;;;; tests/main.lisp

(in-package #:cl-cdsi-tests)

(def-suite all-tests
    :description "The master suite of all cl-cdsi tests.")

(in-suite all-tests)

(defun test-cdsi ()
  (run! 'all-tests))

(test dummy-tests
  "Just a placeholder."
  (is (listp (list 1 2)))
  (is (= 5 (+ 2 3))))
