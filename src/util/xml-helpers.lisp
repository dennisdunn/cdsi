(in-package :cl-cdsi/util)

(defun node-path (node &rest path)
  "Given a path of the form 'property [index] 'property [index] ..., return the indicated node."
  (let ((result (node-by-path node path)))
    (if (and (listp result) (= 1 (length result)))
      (car result)
      result)))

(defun node-text (node)
  "Return the string child of the node."
  (xmls:xmlrep-children node))

(defun node-parse (node parser)
  "Parse the string child of the node with the parser function."
  (funcall parser (node-text node)))

(defun node-tags (node)
  "Get a list of the names of the direct children nodes."
  (let ((n (if (listp node) 
             (car node) 
             node)))
    (remove-duplicates (mapcar #'node-name (node-children n)) :test #'string=)))

(defun node-by-path (node path-list)
  "Given a list of path components, recurse over the node to the final component."
  (let ((selector (car path-list))
        (tail (cdr path-list))
        (next nil))
    (cond((or (null selector)) node)
          (t (progn
               (cond ((keywordp selector) (setf next (antigen selector)))
                     ((and (numberp selector) (listp node) (< selector (length node))) (setf next (nth selector node)))
                     ((symbolp selector) (setf next (xmls:xmlrep-find-child-tags selector node)))
                     (t (error "Invalid selector ~A" selector)))
               (node-by-path next tail))))))


