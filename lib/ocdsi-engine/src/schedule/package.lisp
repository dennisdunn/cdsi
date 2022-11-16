;;;; packages.lisp

(defpackage :schedule
  (:use :cl
        :xmls
        :cl-csv
        :cl-ppcre)
  (:export :antigen
           :antigen-ids
           :schedule))
