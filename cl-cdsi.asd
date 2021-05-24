;;;; cl-cdsi.asd

(defsystem :cl-cdsi
 :description "A vaccine evaluation engine based on the CDC CDSi Logic Spec."
 :author "Dennis Dunn <ansofive@gmail.com>"
 :license "MIT"
 :version "0.1.0"
 :serial t
 :depends-on (:xmls
     :cl-ppcre
     :local-time
     :kebab
     :xlsx)
 :components ((:file "packages")
     (:module "cdsi-date"
      :depends-on ("packages")
      :serial t
      :components ((:file "date-math")))
     (:module "cdsi-supporting-data"
      :depends-on ("packages")
      :serial t
      :components ((:file "data")
                    (:file "parse")))
     (:module "cdsi-testcases"
      :depends-on ("packages")
      :serial t
      :components ((:file "cases")))
                    (:file "cdsi" :depends-on ("cdsi-date" "cdsi-supporting-data"))
                    (:file "structs")))
