(in-package :cl-user)

(defpackage :cdsi.supporting-data
  (:use :cl
        :cdsi.common)
  (:export :catalog
           :antigen
           :vaccine
           :observation
           :patient
           :patient-doses
           :patient-gender
           :gender
           :dose-number
           :cvx->antigens))

(in-package :cdsi.supporting-data)

(defparameter *url* "https://api.opencdsi.org/v2/")

(defun fetch (area key)
  "Get the item specified by area/key as an alist."
  (with-input-from-string (s (dex:get (format nil "~a~(~a~)/~(~a~)/" *url* area key)))
    (json:decode-json s)))

(defun catalog (area)
  "Get a list of the available items from the area."
  (fetch area 'catalog))

(defun antigen (key)
  "Get the specified antigen."
  (fetch 'antigens key))

(defun vaccine (key)
  "Get the specified vaccine."
  (fetch 'vaccines key))

(defun observation (key)
  "Get the specified observation."
  (fetch 'observations key))

(defun patient (key)
  "Get the specified patient."
  (cdr (assoc :patient (fetch 'cases key))))

(defun patient-doses (patient)
  (let ((doses (cdr (assoc :doses patient)))
        (idx 0))
    (mapcar #'(lambda (dose) (acons :number (incf idx) dose)) doses)))

(defun patient-gender (patient)
  (->keyword (cdr (assoc :gender patient))))

(defun dose-number (dose)
  (cdr (assoc :number dose)))

(defun cvx->antigens (cvx)
  "Given the cvx number of the vaccine get the associated antigens."
  (mapcar (lambda (a) (->keyword (get-property :antigen a) :trim nil)) (get-property :association (vaccine cvx))))

