(defsystem :cdsi
  :description "A vaccine evaluation engine based on the CDC CDSi Logic Spec."
  :author "Dennis Dunn <ansofive@gmail.com>"
  :license "MIT"
  :version "0.1.0"
  :serial t
  :depends-on (:support
               :calcdate
               :caselib)
  :components ((:module "src"
                        :serial t
                        :components ((:file "package")
                                     (:file "structs")
                                     (:file "prepare-data")
                                     (:file "select-patient-series")))))

(defsystem :cdsi/tests
  :author "Dennis Dunn <ansofive@gmail.com>"
  :license "MIT"
  :version "0.1.0"
  :depends-on (:cdsi
               :support
               :caselib
               :fiveam)
  :components ((:module "t"
                        :serial t
                        :components ((:file "package")
                                     (:file "main")
                                     (:file "cdsi")))))
