;;;; Convert structs into plists for use by other programs.
(in-package :caselib)

(defun parse-date (datestring)
  "Parse a date of the form 'MM/DD/YYYY'"
  (let* ((parts (cl-ppcre:split "/" datestring))
         (date-parts (mapcar #'parse-integer parts)))
    `(:year ,(third date-parts) :month ,(first date-parts) :day ,(second date-parts))))

(defgeneric to-plist (thing))

;;; Patient records
(defmethod to-plist ((thing patient))
  `(:dob ,(parse-date (patient-dob thing))
         :cob nil
         :gender ,(cond
                   ((string= (patient-gender thing) "F") :female)
                   ((string= (patient-gender thing) "M") :male)
                   (t :unknown))
         :assessment-date ,(parse-date (patient-assessment thing))))

; ;;; Dose records
(defmethod to-plist ((thing dose))
  `(:number ,(parse-integer (dose-number thing))
            :date-administered ,(parse-date (dose-date-administered thing))
            :vaccine-name ,(dose-vaccine-name thing)
            :cvx ,(parse-integer (dose-cvx thing))
            :mvx ,(dose-mvx thing)
            :lot-expiration-date nil
            :lot-number nil))

;;; Testcase records
(defmethod to-plist ((thing testcase))
  (append `(:case-number ,(testcase-id thing))
    (to-plist (testcase-patient thing))
    `(:doses ,(mapcar #'to-plist (testcase-doses thing)))))

(defun dump ()
  (loop for c in (get-cases)
          append (list (testcase-id c) (to-plist c))))

(defun dump-patients (fname)
  (with-open-file (s fname :direction :output :if-exists :supersede)
    (print (dump) s))
  t)