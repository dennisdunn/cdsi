;;;; geometry.lisp

(defpackage :com.ansodesigns.cl-geometry
  (:nicknames :geometry :geom)
  (:use :cl))

(in-package :geometry)


;;;; classes

(defclass point ()
  ((x :initarg :x
      :initform 0
      :reader x)
   (y :initarg :y
      :initform 0
      :reader y)))

(defclass vector (point)
  ())

(defclass line ()
  ((a :initarg :a
      :initform (make-instance 'point)
      :accessor a)
   (b :initform :b
      :initform (make-instance 'point)
      :accessor b)))


;;; vector operations
;;; vectors are of the form  (delta-x delta-y) or (delta-x . delta-y)

(defparameter *zero-vector* (make-instance 'vector))

(defun dot (a b)
  "dot product"
  (+ (*  (x a) (x b)) (* (y a) (y b))))

(defun sum (a b)
  "sum of vectors"
  (make-instance 'vector :x (+ (x a) (x b)) :y (+ (y a) (y b))))

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
