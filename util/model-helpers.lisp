(in-package :cl-cdsi/util)

(defun tags (xmlrep)
  "Get the tags of the direct children."
  (remove-duplicates (mapcar #'xmls:xmlrep-tag (xmls:xmlrep-children xmlrep)) :test #'string=))

(defun tag-value (xmlrep tag)
  (xmls:xmlrep-children (xmls:xmlrep-find-child-tag tag xmlrep)))

(defun defclass% (xmlrep)
  "Define a class congruent with the xmls:xmlrep node."
  (let* ((name (read-from-string (xmls:xmlrep-tag xmlrep)))
         (tags (remove-duplicates (mapcar #'xmls:xmlrep-tag (xmls:xmlrep-children xmlrep)) :test #'string=))
         (slots (mapcar #'(lambda (tag) (read-from-string (kebab:to-kebab-case tag))) tags)))
    (eval `(defclass ,name () ,slots))))

(defun make-instance% (xmlrep)
  (let* ((name (read-from-string (xmls:xmlrep-tag xmlrep)))
         (obj (make-instance name))
         (tags (tags xmlrep)))
    (loop for tag in tags do
            (setf (slot-value obj (read-from-string (kebab:to-kebab-case tag))) (tag-value xmlrep tag)))
    obj))

