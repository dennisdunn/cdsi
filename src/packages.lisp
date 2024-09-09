(in-package :cl-user)

(defpackage :cdsi
  (:use :cl
        :cdsi.common
        :cdsi.calendar
        :cdsi.supporting-data))

(in-package :cdsi)

(defun administered-dose->antigen-doses ();administered-dose)
  "Take an vaccine administered dose from the patient immunization history
  and create one or more antigen administered doses."
  ; get vaccine num
  ; get antigens in the vaccine
  ; make dose for each antigen
  )