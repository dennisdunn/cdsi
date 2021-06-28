(in-package :util)

(defun name->keyword (name)
  "Create a kebab-cased symbol in the KEYWORD package. The name argument is stored on the plist."
  (if (null name)
      nil
      (let ((sym (intern (string-upcase (kebab:to-kebab-case name)) "KEYWORD")))
        (setf (symbol-plist sym) `(:name ,name))
        sym)))

(defun node->string (name source)
  "Get the named node from the source as a string."
  (xmls:xmlrep-string-child (xmls:xmlrep-find-child-tag source name) nil))

(defun node->intervals (name source)
  "Get the named node from the source and parse it into date-math intervals."
  (parse-intervals (node->string (name source))))
