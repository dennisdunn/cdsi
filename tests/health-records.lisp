(in-package :cl-user)

(defpackage :cdsi/tests/health-records
  (:use :cl
        :fiveam
        :cdsi.common
        :cdsi.calendar
        :cdsi.supporting-data
        :cdsi.health-records))

(in-package :cdsi/tests/health-records)

 (def-suite* health-records :in cdsi/tests::cdsi)

; (deftest test-the-patient-interface
;          (testing "fetch patient info by string id"
;                   (let ((record (patient "2013-0004")))
;                     (ok (not (null record)))))

;          (testing "slot access on the patient sturcture"
;                   (let* ((record (patient "2013-0004"))
;                          (dose (car (patient-doses record))))
;                     (ok (eq :f (gender record)))
;                     (ok (eq 1 (dose-number dose)))))

;          (testing "parsing of the patient dob"
;                   (let* ((record (patient "2013-0004"))
;                          (dob (parse-date (getv record :dob))))
;                     (ok (date= (make-date 2020 6 4) dob)))))
