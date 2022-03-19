(in-package :cdsi)

(defun parse-num (o)
  (parse-integer (format nil "~a" o) :junk-allowed t))

(defun prepare-antigen-records (vaccine-records)
  (loop for record in vaccine-records
        collect (make-antigen-record :number (parse-num (caselib:dose-number record))
                                     :date-administered (caselib:dose-date-administered record)
                                     :cvx (parse-num (caselib:dose-cvx record))
                                     :mvx (parse-num (caselib:dose-mvx record))
                                     :antigen nil)))