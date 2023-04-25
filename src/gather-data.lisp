(in-package :cdsi)

(defstruct (antigen-dose (:include cdsi.ehr:dose)
                         (:conc-name antigen-dose-))
  antigen
  (evaluation-status :not-valid))

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
                                      (get-vaccine-antigens (dose-cvx dose))))
                          doses))
      #'string< :key #'antigen-dose-antigen))
