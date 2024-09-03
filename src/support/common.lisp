(in-package :support)

(defparameter *data-path* (uiop:native-namestring #P"~/Documents/Resources/cdsi-supporting-data/")); don't forget the trailing slash!
(defparameter *schedule-name* "ScheduleSupportingData.xml")
(defparameter *antigen-name-glob* "Antigen*.xml")
(defparameter *antigen-name-re* "AntigenSupportingData- (.*)-508")
(defparameter *cases-name* "assessments.json")

(defun load-xml (path)
  "Read and parse the given xml file."
  (with-open-file (stream path)
    (cxml:parse-file stream (cxml-dom:make-dom-builder))))

(defun ->keyword (s)
  "Intern a symbol named s in the keyword package."
  (intern (string-upcase (kebab:to-kebab-case s)) :keyword))

(defun ->tag (s)
  "Return the symbol as a tag."
  (kebab:to-camel-case s))

(defun info (node)
  (let ((h (make-hash-table)))
    (xpath:do-node-set (item (xpath:evaluate "*" (dom:document-element node)))
      (incf (gethash (->keyword (xpath-protocol:local-name item)) h 0)))
    (loop for k being the hash-keys in h using (hash-value v)
          collect (cons k v))))
