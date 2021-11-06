(in-package :cl-cdsi/support)

(defun node->tag (node)
  (tag-attach (node-name node)
              (node-children node)))


(defun node->plist (node)
  (list (name->keyword (node-name node)) (node-children->plist (node-children node))))

(defun node-children->plist (childs)
  (if (and (not (null childs)) (listp childs) (node-p (car childs))) 
    ;(mapcar #'node->plist childs) ; loop goes here
    (loop for c in childs nconc (node->plist c))
    (car childs)))
