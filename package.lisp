;;;; package.lisp

(defpackage #:cl-cdsi-util
  (:nicknames #:util)
  (:use #:cl
        #:kebab
        #:yason
        #:drakma
        #:cl-ppcre
        #:local-time
        #:parse-float)
  (:export :as-date
           :as-number
           :as-gender
           :as-keyword
           :as-boolean
           :as-interval
           :as-number-list
           :keys
           :vals
           :plist-p
           :visit
           :ppath
           :getk
           :fetch
           :*base-url*
           :apply-intervals
           :date+
           :*min-date*
           :*max-date*))

(defpackage #:cl-cdsi
  (:nicknames #:cdsi)
  (:use #:cl
        #:cl-cdsi-util)
  (:export :organize-immunization-history
           :select-relevant-patient-series
           :evaluate-conditional-skip
           :evaluate-dose-administered-condition))
