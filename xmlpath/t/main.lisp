;;;; t/main.lisp
(in-package #:xmlpath/tests)

(def-suite all-tests
    :description "The master suite of all xmlpath tests.")

(in-suite all-tests)

(defun runall ()
  (run! 'all-tests))

(test dummy-tests
  "Just a placeholder."
  (is (listp (list 1 2)))
  (is (= 5 (+ 2 3))))
