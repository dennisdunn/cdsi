;;;; package.lisp

(defpackage #:cl-cdsi-parse
  (:nicknames #:parse)
  (:use #:cl
        #:cl-ppcre
        #:parse-float)
  (:export :as-date
           :as-number
           :as-keyword
           :as-boolean
           :as-interval))

(defpackage #:cl-cdsi-plist
  (:nicknames #:plist)
  (:use #:cl)
  (:export :keys
           :vals
           :plist-p
           :visit))

(defpackage #:cl-cdsi-client
  (:nicknames #:client)
  (:use #:cl
        #:cl-cdsi-parse
        #:cl-cdsi-plist)
  (:export :fetch
           :*base-url*))

(defpackage #:cl-cdsi-date
  (:nicknames #:date)
  (:use #:cl
        #:cl-ppcre
        #:local-time)
  (:export :apply-intervals
           :date+))

(defpackage #:cl-cdsi
  (:nicknames #:cdsi)
  (:use #:cl
        #:cl-cdsi-date
        #:cl-cdsi-parse
        #:cl-cdsi-client))
