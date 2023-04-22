(in-package :cl-cdsi/tests/ehr-interface)

(deftest test-the-enr-interface
  (testing "fetch patient info by string id"
    (let ((record (cl-cdsi/ehr-interface:get-patient-info "2013-0004")))
      (ok (not (null record)))))

  (testing "fetch patient info by numerical id"
    (let ((record (cl-cdsi/ehr-interface:get-patient-info 20130004)))
      (ok (not (null record))))))
