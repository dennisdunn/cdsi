;;;; t/main.lisp
(in-package :calcdate/tests)

(def-suite all-tests
    :description "The master suite of all tests.")

(in-suite all-tests)

(test dummy-tests
  "Just a placeholder."
  (is (listp (list 1 2)))
  (is (= 5 (+ 2 3))))
