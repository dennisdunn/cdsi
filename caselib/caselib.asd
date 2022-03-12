;;;; cl-cdsi.asd

(defsystem :caselib
  :description "CDSi Testcase Library"
  :author "Dennis Dunn <ansofive@gmail.com>"
  :license "MIT"
  :version "0.1.0"
  :serial t
  :depends-on (:cl-csv)
  :components ((:module "src"
                        :serial t
                        :components ((:file "package")
                                     (:file "structs")
                                     (:file "csv")
                                     (:file "caselib")))))

(defsystem :caselib/tests
  :author "Dennis Dunn <ansofive@gmail.com>"
  :license "MIT"
  :version "0.1.0"
  :depends-on (:caselib
               :fiveam)
  :components ((:module "t"
                        :serial t
                        :components ((:file "package")
                                     (:file "main")
                                     (:file "caselib")))))
