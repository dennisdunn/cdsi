(in-package :support)

(defparameter *url* "https://api.opencdsi.org/v2/")

(defun fetch (area key)
  (with-input-from-string (s (dex:get (format nil "~a~(~a~)/~(~a~)/" *url* area key)))
    (json:decode-json s)))

(defun catalog (area)
  (fetch area 'catalog))

(defun antigen (key)
  (fetch 'antigens key))

(defun vaccine (key)
  (fetch 'vaccines key))

(defun observation (key)
  (fetch 'observations key))

(defun patient (key)
  (fetch 'cases key))
