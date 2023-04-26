(in-package :cl-user)

(defpackage :cdsi.gather-data
  (:use :cl
        :cdsi.util
        :cdsi.calendar
        :cdsi.patient
        :cdsi.vaccine)
  (:export :antigen-dose
           :antigen-dose-p
           :antigen-dose-number
           :antigen-dose-administered
           :antigen-dose-vaccine-name
           :antigen-dose-cvx
           :antigen-dose-mvx
           :antigen-dose-antigen
           :antigen-dose-evaluation-status
           :patient-antigen-doses))

(in-package :cdsi.gather-data)

(defstruct (antigen-dose (:include dose)
                         (:conc-name antigen-dose-))
  antigen
  (evaluation-status :not-valid))

(defun patient-antigen-doses (patient)
  (as-antigen-doses (patient-doses patient)))

(defun as-antigen-dose (dose antigen)
  (make-antigen-dose :number (dose-number dose)
                     :date-administered (dose-date-administered dose)
                     :vaccine-name (dose-vaccine-name dose)
                     :cvx (dose-cvx dose)
                     :mvx (dose-mvx dose)
                     :antigen antigen))

(defun as-antigen-doses (doses)
  "Split the vaccine doses into antigen doses."
  (stable-sort (flatten (mapcar #'(lambda (dose)
                                    (mapcar #'(lambda (antigen) (as-antigen-dose dose antigen))
                                      (vaccine-antigens (dose-cvx dose))))
                          doses))
      #'string< :key #'antigen-dose-antigen))
