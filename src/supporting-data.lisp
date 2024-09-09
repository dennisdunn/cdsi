(in-package :cl-user)

(defpackage :cdsi.supporting-data
  (:use :cl
        :cdsi.common)
  (:export :catalog
           :antigen
           :vaccine
           :observation
           :patient
           :get-antigens-from-vaccine
           :get-antigens-from-vaccine-by-cvx
           :get-antigen-doses))

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
  (append (list (cons :key key)) (cdr (assoc :patient (fetch 'cases key)))))

(defun get-antigens-from-vaccine (vaccine)
  "Given the vaccine get the associated antigens."
  (mapcar (lambda (a) (->keyword (get-property :antigen a) :trim nil)) (get-property :association vaccine)))

(defun get-antigens-from-vaccine-by-cvx (cvx)
  "Given the cvx number of the vaccine get the associated antigens."
  (mapcar (lambda (a) (->keyword (get-property :antigen a) :trim nil)) (get-property :association (vaccine cvx))))

(defun get-antigen-doses-for-administered-dose (administered-dose)
  "Make antigen administered doses for the administered vaccine dose."
  (let* ((cvx (assoc :cvx administered-dose))
         (dt (assoc :date-administered administered-dose))
         (antigens (get-antigens-from-vaccine-by-cvx (cdr cvx)))
         (doses (mapcar (lambda (a) (list dt cvx (cons :antigen a))) antigens)))
    doses))

(defun get-antigen-doses (administered-doses)
  "Make sorted antigen administered doses for the administered vaccine doses."
  (let ((doses (mapcan #'get-antigen-doses-for-administered-dose administered-doses)))
    (sort doses #'string-lessp :key (lambda (x) (get-property :date-administered x)))
    (stable-sort doses #'string-lessp :key (lambda (x) (get-property :antigen x)))))
