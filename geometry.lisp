;;;; geometry.lisp

;;; vector operations
;;; vectors are of the form  (delta-x delta-y) or (delta-x . delta-y)

(defparameter *zero-vector* '(0 . 0))

(defun dot (a b)
  "dot product"
  (+ (*  (car a) (car b)) (* (cdr a) (cdr b))))

(defun sum (a b)
  "sum of vectors"
  (list (+ (car a) (car b)) (+ (cdr a) (cdr b))))

(defun reverse-vector (a)
  "reverse the direction of the vector"
  (scale a -1))

(defun magnitude (a)
  "magnitude of the vector"
  (sqrt (+ (expt (car a) 2) (expt (cdr a) 2))))

(defun scale (a s)
  "scalar multiplication of the vector"
  (list (* s (car a)) (* s (cdr a))))

(defun normalize (a)
  "normalize the vector"
  (scale a (/ 1 (magnitude a))))

(defun normal (a)
  "get a normal to the vector"
  (list (* -1 (cdr a)) (car a)))

;;; point operations
;;; points have the form (x y) or (x . y)


;;; line operations
;;; lines are lists (or conses) of two points (start end) or (start . end) eg: ((x_1 . y_1) . (x_2 . y_2))

(defun slope (l)
  "get the slope of the line"
  (/ (- (cddr l) (cadr l)) (- (cdar l) (caar l))))
