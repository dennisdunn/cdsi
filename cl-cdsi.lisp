;;;; cl-cdsi.lisp

(in-package #:cl-cdsi)

(defun split-dose (dose)
  "Take a vaccine administered dose and create a list of antigen administered doses."
  (let* ((cvx (gethash "cvx" dose))
	 (date (gethash "dateAdministered" dose))
	 (antigens (fetch "vaccines" cvx "antigens")))
    (mapcar (lambda (antigen) (list "dateAdministered" date "antigen" antigen)) antigens)))

(defun split-doses (doses)
  (stable-sort (mapcan #'split-dose doses) #'string-lessp :key #'fourth))



