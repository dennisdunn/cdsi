;;;; Networking

(in-package #:cl-cdsi)

(defparameter *base-url* "https://cdsi-api.herokuapp.com/api")

(defun join-fragments (fragments)
  (format nil "~{~A~^/~}" fragments))

(defun url-encode (path)
  (cl-ppcre:regex-replace-all " " path "%20"))

(defun fetch (&rest fragments)
  (let* ((path (join-fragments (push *base-url* fragments)))
	 (url (url-encode path))	 
	 (yason:*parse-object-key-fn* #'string-to-keyword)
	 (stream (drakma:http-request url :want-stream t)))
    (setf (flexi-streams:flexi-stream-external-format stream) :utf-8)
    (yason:parse stream :object-as :plist)))

(defun string-to-keyword (thing)
  (cond ((and (stringp thing) (> (length thing) 0))  (intern (string-upcase (kebab:to-kebab-case thing)) "KEYWORD"))
	((and (stringp thing) (= (length thing) 0)) nil)
	(t thing)))

(defun safe-parse-timestring (thing)
  (if (stringp thing)
      (local-time:parse-timestring thing :fail-on-error nil)
      thing))

(defun plist-keys (plist)
  (loop :for (a b) :on plist :by #'cddr :while b
	:collect a))

(defun plist-values (plist)
  (loop :for (a b) :on plist :by #'cddr :while b
	:collect b))

(defun plist-p (thing)
  (and
   (consp thing)
   (eq 0 (rem (length thing) 2))
   (every #'identity (mapcar #'symbolp (plist-keys thing)))))

(defun with-plist-key (fn key)
  (lambda (plist)
    (let ((value (getf plist key)))
      (when value
	(setf (getf plist key) (funcall fn value))))))

(defun visit (fn thing)
  (if (plist-p thing) (funcall fn thing))
  (if (listp thing) (mapc #'(lambda (thing) (visit fn thing)) thing))
  thing)

(defun convert-values (fn keys thing)
  (let ((fns (mapcar (lambda (key) (with-plist-key fn key)) keys)))
    (mapc (lambda (fn) (visit fn thing)) fns))
  thing)

