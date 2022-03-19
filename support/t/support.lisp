(in-package #:support/tests)

(def-suite support-tests
  :description "Test the supporting data functions."
  :in all-tests)

(in-suite support-tests)

(defparameter *cvxmap* (support:cvx-antigen-map (support:schedule)))

(test get-cvx-from-map
  "Fetch cvx from the schedule data."
  (let ((cvx (support:get-cvx *cvxmap* 4)))
    (is (not (null cvx)))))

(test get-antigens
  "Fetch a list of antigens for a cvx."
  (let* ((cvx (support:get-cvx *cvxmap* 4))
         (antigens (support:get-antigens cvx)))
    (print antigens)
    (is (not (null cvx)))))