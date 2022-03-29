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
                                     (:file "config")
                                     (:file "structs")
                                     (:file "csv")
                                     (:file "caselib"))))
  :in-order-to ((test-op (test-op :caselib/tests))))

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
                                     (:file "caselib"))))
  :perform (test-op (op c) (symbol-call :fiveam :run!
                                        (find-symbol* 'all-tests :caselib/tests))))
