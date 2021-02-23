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

(defmacro getk (list key)
  "Get a value from a plist or get the nth item in the list."
  (cond ((symbolp key) `(getf ,list ,key))
        ((numberp key) `(nth ,key ,list))))

(defmacro ppath (list keys)
  "Given a nested plist (aka ptree) and a list of keys, extract an object from the plist.

For example, to get the unit of the *conditions* first begin-age interval from a condition,
call (ppath *condition* (:begin-age 0 :unit))

(GETF (NTH 0 (GETF *CONDITION* :BEGIN-AGE)) :UNIT)"
  (let ((key (first keys))
        (rest (rest keys)))
    (if (null keys)
        list
        `(ppath (getk ,list ,key) ,rest))))