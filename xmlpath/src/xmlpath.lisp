(in-package :xmlpath)

(defun child->symbol (node)
  "Since numbers are symbols this will parse the text child and return a number or a kebabbed symbol."
  (read-from-string (substitute #\- #\Space (car (xmls:xmlrep-children node)))))

(defun find-child-tags (node tag)
  "Recursivly locate all nodes of type tag."
  (cond ((not (xmls:node-p node)) nil)
        ((eq tag (read-from-string (xmls:xmlrep-tag node))) `(,node))
        (t (loop for child in (xmls:xmlrep-children node)
                 append (find-child-tags child tag)))))

(defun select-p (node tag arg)
  "Return T iff the node has a single child node whose only child matches the arg symbol."
  (let* ((selector (xmls:xmlrep-find-child-tag (string tag) node))
         (operand (child->symbol selector)))
    (eq arg operand)))
