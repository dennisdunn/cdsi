;;;; util/package.lisp

(defpackage :cl-cdsi/util
  (:nicknames :u)
  (:use :cl
        :cl-ppcre
        :xmls
        :local-time)
  (:export :name->keyword
           :keyword->name
           :keyword->camel-case
           :alist->node
           :kvp->alist
           :node->plist
           :defmodel
           :defclass%
           :make-instance%
           :parse-date
           :parse-intervals
           :parse-and-adjust
           :adjust
           :date+
           :node-path
           :node-tags
           :node-text
           :node-parse
           :node->plist
           :node-collect-properties
           :csv-read
           :csv-headers
           :csv-column
           :csv-row
           :csv-find
           :flatten))
