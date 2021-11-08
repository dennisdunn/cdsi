;;;; packages.lisp

  (defpackage :cl-cdsi/support
    (:nicknames :db)
    (:use :cl
          :xmls
          :cl-csv
          :cl-ppcre
          :cl-cdsi/util)
    (:export :antigen
             :antigen-ids
             :schedule
             :testcase
             :testcase-ids))
