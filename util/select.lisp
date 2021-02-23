;;;; select.lisp

;;;; Access values in nested plists.

(defun keys (plist)
  (loop :for (a b) :on plist :by #'cddr
        :while a
        :collect a))

(defun plist-p (thing)
  (and
   (listp thing)
   (evenp (length thing))
   (every #'symbolp (keys thing))))

(defun plist-get (plist key)
  (if (symbolp key)
      (getf plist key)
      (nth key plist)))

(defun ppath (plist path)
  (let* ((head (first path))
	 (tail (rest path))
	 (thing (plist-get plist head)))
    (if (null tail)
	thing
	(ppath thing tail))))

(defmacro ppath2 (ptree path)
  (print ptree)
  (let* ((head (first path))
	 (tail (rest path))
	 (thing (plist-get ptree head)))    
    (cond ((null head) `,thing)
	  ((symbolp head) `(ppath2 (getf ,thing ,head) ,tail))
	  ((numberp head) `(ppath2 (nth ,head ,thing) ,tail))
	  (t (error "ppath2: key should be a symbol or an integer")))))


(defmacro j (things)
  `(list ,@things))

;get the first set from the first conditional skip
;(nth 0 (getf (nth 0 (getf *dose* :conditional-skip)) :set))

(defun select (&key (key :all) from (where #'identity))
  (cond ((plist-p from) (if (eq key :all)
			    from
			    (getf from key)))
	((listp from) (mapcar (lambda (thing) (select :key key :from thing))
			      (remove-if-not where from)))))

(defmacro is (&rest args)
  `(lambda (thing)
       (and ,@(loop :for (a b) :on args :by #'cddr
		    :while a
		    :collect `(eq (getf thing ,a) ,b)))))
