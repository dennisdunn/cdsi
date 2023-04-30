(in-package :cdsi.lib)

;;;; Sequence helpers

(defun flatten (lst)
  "Flatten the list lst
   https://stackoverflow.com/questions/49780045/lisp-list-linearization-with-map"
  (cond ((null lst) nil)
        ((atom lst) (list lst))
        (t (loop for e in lst appending (flatten e)))))

;;;; If handle-case catches a condition then simply return nil. Dangerous? Yeah.

(defmacro with-nil-handler (&rest body)
  "Evaluate the body and return nil iff a condition occurs."
  `(handler-case (progn ,@body) (error nil)))

;;;; Xml helpers

(defun get-value (parser node tag)
  "Try to parse the child node and return a value or nil if the parser fails."
  (with-nil-handler
    (funcall parser (car (xmls:xmlrep-children (xmls:xmlrep-find-child-tag tag node))))))

(defun get-string-value (node tag)
  (get-value #'identity node tag))

(defun get-integer-value (node tag)
  (get-value #'parse-integer node tag))

(defun get-bool-value (node tag)
  (get-value #'parse-bool node tag))

(defun get-keyword-value (node tag)
  (get-value #'parse-keyword node tag))

(defun get-date-value (node tag)
  (get-value #'parse-date node tag))

(defun get-interval-value (node tag)
  (get-value #'parse-interval node tag))
