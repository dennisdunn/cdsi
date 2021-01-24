;;;; cl-cdsi.lisp

(in-package #:cl-cdsi)

(defun split-dose (dose)
  "Take a vaccine administered dose and create a list of antigen administered doses."
  (let* ((cvx (getf dose :cvx))
         (date (getf dose :date-administered))
         (antigens (fetch "vaccines" cvx "antigens")))
    (mapcar (lambda (antigen) (list :date-administered date :antigen antigen)) antigens)))

(defun split-doses (doses)
  (stable-sort (mapcan #'split-dose doses) #'string-lessp :key #'fourth))
