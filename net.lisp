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
	 (yason:*parse-object-key-fn* #'convert-to-keyword)
	 (stream (drakma:http-request url :want-stream t)))
    (setf (flexi-streams:flexi-stream-external-format stream) :utf-8)
    (yason:parse stream :object-as :plist)))

(defun convert-to-keyword (js-name)
  (intern (string-upcase (kebab:to-kebab-case js-name)) "KEYWORD"))

