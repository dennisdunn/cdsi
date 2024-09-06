(in-package :cl-user)

(defpackage :cdsi.supporting-data
  (:import-from :cdsi.common #:->keyword)
  (:use :cl)
  (:export :catalog
           :antigen
           :vaccine
           :observation
           :patient))

(in-package :cdsi.supporting-data)

(defparameter *url* "https://api.opencdsi.org/v2/")

(defun fetch (area key)
  "Get the item specified by area/key as an alist."
  (with-input-from-string (s (dex:get (format nil "~a~(~a~)/~(~a~)/" *url* area key)))
    (json:decode-json s)))

(defun tag (area l)
  "Add a (:type . area) cons to the list."
  (let ((keyword (->keyword area)))
    (push (cons :type keyword) l)))

(defun catalog (area)
  "Get a list of the available items from the area."
  (let ((l (fetch area 'catalog)))
    (push (cons :type :catalog) l)))

(defun antigen (key)
  "Get the specified antigen."
  (tag 'antigens (fetch 'antigens key)))

(defun vaccine (key)
  "Get the specified vaccine."
  (tag 'vaccines (fetch 'vaccines key)))

(defun observation (key)
  "Get the specified observation."
  (tag 'observations (fetch 'observations key)))

(defun patient (key)
  "Get the specified patient."
  (tag 'patient (append (list (cons :key key)) (cdr (assoc :patient (fetch 'cases key))))))
