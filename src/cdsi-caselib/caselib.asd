;;;; cl-cdsi.asd

(defsystem :org.opencdsi.caselib
           :description "CDSi Testcase Library"
           :author "Dennis Dunn <ansofive@gmail.com>"
           :license "MIT"
           :version "0.1.0"
           :serial t
           :depends-on (:fiveam
                        :cl-csv)
           :components ((:module "src"
                                 :serial t
                                 :components ((:file "package")
                                              (:file "config")
                                              (:file "structs")
                                              (:file "csv")
                                              (:file "caselib")))))

(defsystem :org.opencdsi.caselib/tests
           :author "Dennis Dunn <ansofive@gmail.com>"
           :license "MIT"
           :version "0.1.0"
           :depends-on (:org.opencdsi.caselib
                        :fiveam)
           :components ((:module "t"
                                 :serial t
                                 :components ((:file "package")
                                              (:file "main")
                                              (:file "caselib")))))
