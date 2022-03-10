(in-package :cl-cdsi/util)

(defun name->keyword (name)
  "Create a kebab-cased symbol in the KEYWORD package. The name argument is stored on the plist."
  (if (null name)
    nil
    (let ((sym (intern (string-upcase (kebab:to-kebab-case name)) "KEYWORD")))
      (setf (symbol-plist sym) `(:name ,name))
      sym)))

(defun keyword->name (key)
  "Get the name of the previously interned keyword."
  (getf (symbol-plist key) :name))

(defun keyword->camel-case (key)
  "Camel case the name of the keyword."
  (kebab:to-camel-case (keyword->name key)))

(defun kvp->alist (keys values)
  "Return an alist of (key . value)"
  (loop for key in keys
        for val in values
        collect (cons (keyword->camel-case (car key)) val)))

(defun alist->node (name alist)
  "Make an xmls:node from the association list."
  (xmls:make-node :name name
                  :children (mapcar #'(lambda (kvp) (xmls:make-node :name (car kvp) :children (cdr kvp))) alist)))

