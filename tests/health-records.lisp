(in-package :cl-user)

(defpackage :cdsi/tests/health-records
  (:use :cl
        :fiveam
        :cdsi/core
        :cdsi/core/calendar
        :cdsi/core/supporting-data
        :cdsi/core/health-records))

(in-package :cdsi/tests/health-records)

(def-suite* health-records :in cdsi/tests::cdsi)

(test fetch-patient-info-by-id
         (let ((record (patient "2013-0004")))
           (is (not (null record)))))

(test slot-access-on-the-patient-sturcture
         (let* ((record (patient "2013-0004"))
                (dose (car (patient-doses record))))
           (is (eq :f (gender record)))
           (is (eq 1 (dose-number dose)))))

(test parse-the-patient-dob
         (let* ((record (patient "2013-0004"))
                (dob (parse-date (getv record :dob))))
           (is (date= (make-date 2020 6 4) dob))))
