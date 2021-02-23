
(defun join (&rest args)
  (format nil "~{~A~^/~}" args))

(defun save-it (fname data)
  (with-open-file (stream ((join "~" "projects" "cl-cdsi")
			   :direction :output
			   :if-exists :supersede
			   :if-does-not-exist :create))
    (format stream data)))
