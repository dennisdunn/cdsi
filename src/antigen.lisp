(in-package :cdsi.antigen)

(defun antigen (name)
  "Fetch the node for the named antigen."
  (cdsi.data:get-antigen name))

(defun antigen-series (treenode)
  "Fetch all of the series for an antigen xml node."
  (xmls:xmlrep-find-child-tags "series" treenode))

(defun series-type (treenode)
  "Get the series type from the series xml node."
  (get-keyword-value treenode "seriesType"))

(defun series-gender (treenode)
  "Get the required gender from the series xml node."
  (get-keyword-value treenode "requiredGender"))

(defun series-indications (treenode)
  "Fetch all of the indications for the series xml node."
  (xmls:xmlrep-find-child-tags "indication" treenode))

(defun indication-observation-code (treenode)
  (xmls:xmlrep-find-child-tag treenode "observationCode"))

(defun indication-description (treenode)
  (get-string-value treenode "description"))

(defun indication-guidance (treenode)
  (get-string-value treenode "guidance"))

(defun indication-begin-age (treenode)
  (get-date-value treenode "beginAge"))

(defun indication-end-age (treenode)
  (get-date-value treenode "endAge"))

(defun observation-text (treenode)
  (get-string-value treenode "text"))

(defun observation-code (treenode)
  (get-string-value treenode "code"))
