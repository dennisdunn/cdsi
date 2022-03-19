(defsystem :xmlpath
  :description "A very simple xpath-ish utility."
  :author "Dennis Dunn <ansofive@gmail.com>"
  :license "MIT"
  :version "0.1.0"
  :serial t
  :depends-on (:xmls
               :parser-combinators)
  :components ((:module "src"
                        :serial t
                        :components ((:file "package")
                                     (:file "xmlpath")))))

(defsystem :xmlpath/tests
  :author "Dennis Dunn <ansofive@gmail.com>"
  :license "MIT"
  :version "0.1.0"
  :depends-on (:xmlpath
               :fiveam)
  :components ((:module "t"
                        :serial t
                        :components ((:file "package")
                                     (:file "main")
                                     (:file "xmlpath")))))
