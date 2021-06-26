;;;; packages.lisp
(defpackage :util
  (:use :cl
        :kebab)
  (:export :name->keyword))

(defpackage :date-math
  (:nicknames :dates)
  (:use :cl
        :local-time)
  (:export :apply-intervals))

(defpackage :supporting-data
  (:nicknames :support)
  (:use :cl
        :xmls
        :util
        :cl-ppcre)
  (:export :antigen-keys
           :get-antigen
           :get-series
           :get-schedule
           :series-standard-p
           :series-required-genders))

(defpackage :testcases
  (:use :cl
        :kebab
        :cl-csv))

(defpackage :cl-cdsi
  (:nicknames :cdsi)
  (:use :cl
        :date-math
        :supporting-data))
