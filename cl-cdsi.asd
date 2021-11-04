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
           :components ((:module "src" 
                                 :serial t 
                                 :components ((:module "util"
                                                       :serial t
                                                       :components ((:file "package")
                                                                    (:file "util")
                                                                    (:file "tags")
                                                                    (:file "date-math")))
                                              (:module "support"
                                                       :serial t
                                                       :components ((:file "package")
                                                                    (:file "params")
                                                                    (:file "structs")
                                                                    (:file "testcase-data")
                                                                    (:file "schedule-data")
                                                                    (:file "supporting-data")))
                                              (:module "cdsi"
                                                       :serial t
                                                       :components ((:file "package")
                                                                    (:file "select-patient-series")))))))

(defsystem :cl-cdsi/tests
           :author "Dennis Dunn <ansofive@gmail.com>"
           :license "MIT"
           :version "0.1.0"
           :depends-on (:cl-cdsi
                         :fiveam)
           :components ((:module "t"
                                 :serial t
                                 :components ((:file "package")
                                              (:file "main")
                                              (:file "support")
                                              (:file "date-time")))))

