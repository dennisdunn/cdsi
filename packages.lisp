;;;; packages.lisp

(defpackage :cdsi-date
  (:nicknames :dates)
  (:use :cl)
  (:import-from :local-time
                :encode-timestamp
                :adjust-timestamp
                :timestamp-day
                :timestamp-month
                :timestamp-year
                :days-in-month)
  (:export :apply-intervals))

(defpackage :cdsi-supporting-data
  (:nicknames :suport)
  (:use :cl)
  (:import-from :cl-ppcre
                :regex-replace-all
                :scan
                :all-matches-as-strings
                :split
                :register-groups-bind
                :regex-replace)
  (:import-from :kebab
                :to-kebab-case)
  (:import-from :xmls
                :parse))


(defpackage :cl-cdsi
  (:nicknames :cdsi)
  (:use :cl
        :cdsi-date
        :cdsi-supporting-data))
