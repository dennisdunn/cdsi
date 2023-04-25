(in-package :cdsi/tests/cdsi)

(defparameter *patient* (cdsi.ehr:get-patient 20130004))

(deftest test-gather-data-for-evaluation
  (testing "the generation of antigen doses"
    (let ((doses (as-antigen-doses (patient-doses *patient*))))
      (ok (eq (length doses) 6))
      (ok (antigen-dose-p (car doses)))))
  (testing "can access superclass slots of antigen-dose"
    (let ((dose (car (as-antigen-doses (patient-doses *patient*)))))
      (ok (eq 107 (dose-cvx dose))))))
