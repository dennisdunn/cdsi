;;;; Property list tools

(in-package #:cl-cdsi-util)

(defun keys (plist)
  (loop :for (a b) :on plist :by #'cddr
        :while b
        :collect a))

(defun vals (plist)
  (loop :for (a b) :on plist :by #'cddr
        :while a
        :collect b))

(defun plist-p (thing)
  (and
   (listp thing)
   (evenp (length thing))
   (every #'symbolp (keys thing))))

(defun visit (fn thing)
  "Visit each node in a 'property tree' and apply fn to the node. A 'property tree' is a property list with values that can be another property list or a list of property lists."
  (if (plist-p thing) (ignore-errors (funcall fn thing)))
  (if (listp thing) (mapc #'(lambda (thing) (visit fn thing)) thing))
  thing)
