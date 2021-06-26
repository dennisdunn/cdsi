;;;; cl-cdsi.asd

(defsystem :cl-cdsi
 :description "A vaccine evaluation engine based on the CDC CDSi Logic Spec."
 :author "Dennis Dunn <ansofive@gmail.com>"
 :license "MIT"
 :version "0.1.0"
 :serial t
 :depends-on (:local-time
     :cl-ppcre
     :cl-csv
     :kebab
     :xlsx
     :xmls)
 :components ((:file "packages")
     (:file "util")
     (:file "date-math")
     (:file "supporting-data")
     (:file "testcases")))
