(in-package :support)

(defparameter *url* "https://api.opencdsi.org/v2/")

(defun fetch (area key)
  (with-input-from-string (s (dex:get (format nil "~a~(~a~)/~(~a~)/" *url* area key)))
    (json:decode-json s)))

(defun tag (area l)
  (let ((keyword (intern (string-right-trim "S" (string-upcase (string area))) :keyword)))
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

(defun get-property (key alist)
  (cdr (assoc key alist)))

(defun set-property (key alist value)
  (setf (cdr (assoc key alist)) value))
