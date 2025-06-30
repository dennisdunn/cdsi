(in-package :cl-user)

(defpackage :cdsi.gather-info
  (:use :cl
        :cdsi.common
        :cdsi.supporting-data)
  (:export :vaccine-doses->antigen-doses))

(in-package :cdsi.gather-info)

(defun vaccine-dose->antigen-doses (vaccine-dose)
  "Make antigen administered doses for the administered vaccine dose."
  (let* ((cvx (assoc :cvx vaccine-dose))
         (dt (assoc :date-administered vaccine-dose))
         (antigens (cvx->antigens (cdr cvx)))
         (doses (mapcar (lambda (a) (list dt cvx (cons :antigen a) (cons :status :not-evaluated))) antigens)))
    doses))

(defun vaccine-doses->antigen-doses (vaccine-doses)
  "Make sorted antigen administered doses for the administered vaccine doses."
  (let ((doses (mapcan #'vaccine-dose->antigen-doses vaccine-doses)))
    (sort doses #'string-lessp :key (lambda (x) (getv x :date-administered)))
    (stable-sort doses #'string-lessp :key (lambda (x) (getv x :antigen)))))