;;;;cl-cdsi.asd

(defsystem :org.opencdsi.engine
           :description"A vaccine evaluation engine based on the CDC CDSi Logic Spec."
           :author"Dennis Dunn <ansofive@gmail.com>"
           :license"MIT"
           :version"0.1.0"
           :serialt
           :depends-on
           (:xmls
            :kebab
            :cl-csv
            :cl-ppcre
            :local-time)
           :components
           ((:module "calcdate"
                     :serial t
                     :components
                     ((:file "package")
                      (:file "calcdate")))
            (:module "schedule"
                     :serial t
                     :components
                     ((:file "package")
                      (:file "schedule")
                      (:file "antigen")))
            (:module "engine"
                     :serial t
                     :components
                     ((:file "package")
                      (:file "select-patient-series")))))

(defsystem :org.opencdsi.engine/tests
           :author"Dennis Dunn <ansofive@gmail.com>"
           :license"MIT"
           :version"0.1.0"
           :depends-on
           (:org.opencdsi.engine
            :fiveam)
           :components
           ((:module "t"
                     :serial t
                     :components
                     ((:file "package")
                      (:file "main")
                      (:file "calcdate")
                      (:file "schedule")
                      (:file "engine")))))
