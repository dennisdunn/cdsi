;;;; cl-cdsi.asd

(asdf:defsystem #:cl-cdsi
  :description "Describe cl-cdsi here"
  :author "Dennis Dunn <ansofive@gmail.com>"
  :license  "MIT"
  :version "0.0.1"
  :depends-on (#:drakma #:yason #:cl-ppcre)
  :serial t
  :components ((:file "package")
	       (:file "util")
	       (:file "net")
               (:file "cl-cdsi")))
