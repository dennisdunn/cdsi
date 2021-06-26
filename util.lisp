(in-package :util)

(defun name->keyword (name)
  "Create a kebab-cased symbol in the KEYWORD package. The name argument is stored on the plist."
  (if (null name)
    nil
  (let ((sym (intern (string-upcase (kebab:to-kebab-case name)) "KEYWORD")))
    (setf (symbol-plist sym) `(:name ,name))
    sym)))
