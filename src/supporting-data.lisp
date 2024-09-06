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
  (with-input-from-string (s (dex:get (format nil "~a~(~a~)/~(~a~)/" *url* area key)))
    (json:decode-json s)))

(defun tag (area l)
  (let ((keyword (->keyword area)))
    (push (cons :type keyword) l)))

(defun catalog (area)
  (let ((l (fetch area 'catalog)))
    (push (cons :type :catalog) l)))

(defun antigen (key)
  (tag 'antigens (fetch 'antigens key)))

(defun vaccine (key)
  (tag 'vaccines (fetch 'vaccines key)))

(defun observation (key)
  (tag 'observations (fetch 'observations key)))

(defun patient (key)
  (tag 'patient (append (list (cons :key key)) (cdr (assoc :patient (fetch 'cases key))))))
