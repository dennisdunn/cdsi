(in-package :cdsi)

(defstruct patient-series
  antigen ; eg "Tetanus"
  name ; eg "Standard 2-dose"
  type ; risk, standard, etc
  status) ; satisfied, not satisfied, skipped, etc

; (defun get-antigen-series (antigen)
;   (cdsi.data:antigen))
