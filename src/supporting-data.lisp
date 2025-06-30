(in-package :cl-user)

(defpackage :cdsi.supporting-data
  (:use :cl
        :cdsi.common)
  (:import-from :cdsi.calendar #:parse-date)
  (:export :areas
           :catalog
           :antigen
           :vaccine
           :observation
           :gender
           :dose-number
           :cvx->antigens))

(in-package :cdsi.supporting-data)

;;;; API helpers

(defun areas ()
  "Get a list of the supporting data content sections."
  (list 'antignes 'vaccines 'observations))

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

;;;; General helpers

(defun dose-number (record)
  "Get the dose number from the record."
  (getv record :number))

(defun gender (record)
  "Get the gender from the record."
  (->keyword (getv record :gender)))

(defun dob (record)
  "Get the date of birth from the record."
  (parse-date (getv record :dob)))

(defun cvx->antigens (cvx)
  "Given the cvx number of the vaccine get the associated antigens."
  (mapcar (lambda (a) (->keyword (getv a :antigen) :trim nil)) (getv (vaccine cvx) :association)))
