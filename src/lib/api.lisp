(in-package :cdsi.api)

(defparameter *base-url* "https://opencdsi.org/ocdsi-api/")

;;;; Format strings for the API endpoints.
(defparameter *antigen-catalog* "v1/antigens/")
(defparameter *vaccine-catalog* "v1/vaccines/")
(defparameter *observation-catalog* "v1/observations/")
(defparameter *vaccine-group-catalog* "v1/groups/")
(defparameter *case-catalog* "v1/cases/")

(defparameter *antigen-by-id* "v1/antigens/~a/")
(defparameter *series-by-antigen-id* "v1/antigens/~a/series/")
(defparameter *series-by-antigen-id-series-name* "v1/antigens/~a/series/~a/")

(defparameter *vaccine-by-cvx* "v1/vaccines/~a/")

(defparameter *observation-by-code* "v1/observations/~a/")

(defparameter *vaccine-group-by-name* "v1/groups/~a/")

(defparameter *case-by-id* "v1/cases/~a/")
(defparameter *medical-by-case-id* "v1/cases/~a/medical/")

(defun fetch-data (url &optional (fmt :plist))
  (let ((stream (drakma:http-request url :want-stream t)))
    (setf (flexi-streams:flexi-stream-external-format stream) :utf-8)
    (multiple-value-bind (data _) (yason:parse stream :object-key-fn #'->keyword :object-as fmt)
      data)))

(defun expand-url (fragment &rest vars)
  (concatenate 'string *base-url* (apply #'format (append (list nil fragment) vars)) "index.json"))

(defun fetch (&rest args)
  (fetch-data (apply #'expand-url args)))

;;;; Intern a string or symbol in the KEYWORD package.
(defun ->keyword (name &optional (plural 1))
  "Intern a symbol named by the argument into the KEYWORD package."
  (intern (format nil "~:@(~a~p~)" (kebab:to-kebab-case (string name)) plural) :keyword)) 

;;;; Antigens

(defun antigen-catalog ()
  (fetch *antigen-catalog*))

(defun antigen (id)
  (fetch *antigen-by-id* id))

(defun antigen-series (id)
  (fetch *series-by-antigen-id* id))

;;;; Vaccines

(defun vaccine-catalog ()
  (fetch *vaccine-catalog*))

(defun vaccine (cvx)
  (fetch *vaccine-by-cvx* cvx))

;;;; Observations

(defun observation-catalog ()
  (fetch *observation-catalog*))

(defun observation (code)
  (fetch *observation-by-code* code))

;;;; Vaccine groups

(defun vaccine-group-catalog ()
  (fetch *vaccine-group-catalog*))

;;;; Cases

(defun case-catalog ()
  (fetch *case-catalog*))

(defun case-item (id)
  (fetch *case-by-id* id))

(defun case-medical (id)
  (fetch *medical-by-case-id* id))
