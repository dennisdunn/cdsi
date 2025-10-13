(in-package :cl-user)

(defpackage :cdsi/core
  (:use :cl
        :kebab)
  (:nicknames :core)
  (:export :->keyword
           :getv
           :setv
           :repv
           :alistp
           :aconsp
           :fetch))

(in-package :cdsi/core)

(defun ->keyword (s &key (trim "S"))
  "Intern a string or symbol in the KEYWORD package."
  (intern (string-right-trim trim (string-upcase (kebab:to-kebab-case (string s)))) :keyword))

;;;; Association list helprs

(defun alistp (item)
  "If a list has an assoc cons cell as the first item, then it must be an alisst."
  (when (listp item)
       (aconsp (car item))))

(defun aconsp (item)
  "Is the item an association list cons cell."
  (when (consp item)
        (and (symbolp (car item))
             (or (atom (cdr item))
                 (listp (cdr item))))))

(defun getv (alist key)
  "Get the value of the key from the alist."
  (cdr (assoc key alist)))

; (defun setv (alist key value)
;   "Set the value of the key from the alist."
;   (push (cons key value) alist))

(defun setv (acons value)
  "Set the cdr of the cons sell to value."
  (setf (cdr acons) value))

(defun repv (fn acons)
  "Apply fn to the cdr of the association list cons cell."
  (setv acons (apply fn `(,(cdr acons)))))



;;;; API access to the supporting data and test cases

(defparameter *url* "https://api.opencdsi.org/v1/")

(defun fetch (area key)
  "Get the item specified by area/key as an alist."
  (with-input-from-string (s (dex:get (format nil "~a~(~a~)/~(~a~)/" *url* area key)))
    (json:decode-json s)))
