(in-package :cdsi/tests/patient)

(deftest test-the-patient-interface
         (testing "fetch patient info by string id"
                  (let ((record (patient "2013-0004")))
                    (ok (not (null record)))))

         (testing "fetch patient info by numerical id"
                  (let ((record (patient 20130004)))
                    (ok (not (null record)))))

         (testing "slot access on the patient sturcture"
                  (let* ((record (patient 20130004))
                         (dose (car (patient-doses record))))
                    (ok (eq :f (patient-gender record)))
                    (ok (eq 1 (dose-number dose))))))
