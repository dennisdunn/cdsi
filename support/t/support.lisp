(in-package #:support/tests)

(def-suite support-tests
  :description "Test the supporting data functions."
  :in all-tests)

(in-suite support-tests)

(test get-cvx-from-map
  "Fetch cvx from the schedule data."
  (let ((cvx (support:get-cvx 4)))
    (is (not (null cvx)))))

(test get-antigens
  "Fetch a list of antigens for a cvx."
  (let ((antigens (support:get-antigens 132)))
    (print antigens)
    (is (not (null antigens)))))