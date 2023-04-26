(in-package :cl-user)

(defpackage :cdsi.antigen
  (:use :cl
        :cdsi.util)
  (:export))

(in-package :cdsi.antigen)

;;;; Antigen data

(defstruct indication
  observation-code
  description
  begin-age
  end-age
  guidance)

(defstruct observation-code
  text
  code)

(defun get-antigen-data (antigen)
  "Fetch the node for the names antigen."
  (cdsi.data:get-antigen antigen))

(defun get-antigen-series (node)
  "Fetch all of the series for an antigen node."
  (xmls:xmlrep-find-child-tags "series" node))

(defun get-series-type (node)
  "Get the series type from the series node."
  (get-keyword-value node "seriesType"))

(defun get-series-gender (node)
  "Get the required gender from the series node."
  (get-keyword-value node "requiredGender"))

(defun get-series-indications (node)
  "Get the series indications from the series node."
  (with-nil-handler
    (mapcar #'as-indication
    (xmls:xmlrep-find-child-tag "indication" node))))

(defun as-indication (node)
  (make-indication :observation-code (as-observation-code (xmls:xmlrep-find-child-tag node "observationCode"))
                   :description (get-string-value node "description")
                   :begin-age (get-date-value node "beginAge")
                   :end-age (get-date-value node "endAge")
                   :guidance (get-string-value node "guidance")))

(defun as-observation-code (node)
  (make-observation-code :text (get-string-value node "text")
                         :code (get-string-value node "code")))
