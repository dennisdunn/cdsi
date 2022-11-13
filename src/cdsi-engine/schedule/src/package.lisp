;;;; packages.lisp

(defpackage :support
  (:use :cl
        :xmls
        :cl-csv
        :cl-ppcre)
  (:export :antigen
           :antigen-ids
           :schedule))
