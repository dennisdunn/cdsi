;;;;cl-cdsi.asd

(defsystem :ocdsi-engine
           :description "A vaccine evaluation engine based on the CDC CDSi Logic Spec."
           :author "Dennis Dunn <ansofive@gmail.com>"
           :license "MIT"
           :version "0.1.0"
           :serial t
           :depends-on (:xmls
                        :kebab
                        :cl-csv
                        :cl-ppcre
                        :local-time)
           :components ((:module "src"
                                 :components ((:module "calcdate"
                                                       :serial t
                                                       :components ((:file "package")
                                                                    (:file "calcdate")))
                                              (:module "schedule"
                                                       :serial t
                                                       :components ((:file "package")
                                                                    (:file "schedule")
                                                                    (:file "antigen")))
                                              (:module "gather-data"
                                                       :serial t
                                                       :components ((:file "package")
                                                                    (:file "select-patient-series")))))))

(defsystem :ocdsi-engine/tests
           :author "Dennis Dunn <ansofive@gmail.com>"
           :license "MIT"
           :version "0.1.0"
           :depends-on (:ocdsi-engine
                        :fiveam)
           :components ((:module "t"
                                 :serial t
                                 :components
                                 ((:file "package")
                                  (:file "main")
                                  (:file "patient-info")
                                  (:file "calcdate")
                                  (:file "schedule")
                                  (:file "engine")))))
