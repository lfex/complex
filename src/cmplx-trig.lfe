(defmodule cmplx-trig
  (export (cos 1)
          (sin 1)
          (tan 1)
          (csc 1)
          (sec 1)
          (cot 1)
          (cosh 1)
          (sinh 1)
          (tanh 1)
          (csch 1)
          (sech 1)
          (coth 1)))

(include-lib "complex/include/data-types.lfe")

;; Trigonometric functions

(defun cos
  (((match-complex real r img i))
   (complex:new (* (math:cos r) (math:cosh i))
                (* -1 (math:sin r) (math:sinh i)))))

(defun sin
  (((match-complex real r img i))
   (complex:new (* (math:sin r) (math:cosh i))
                (* (math:cos r) (math:sinh i)))))

(defun tan (z)
  (/ (sin z)
     (cos z)))

(defun csc (z)
  (/ 1 (sin z)))

(defun sec (z)
  (/ 1 (cos z)))

(defun cot (z)
  (/ 1 (tan z)))

;; Hyperbolic trigonometric functions

(defun sinh
  (((match-complex real r img i))
   (complex:new (* (math:sinh r) (math:cos i))
                (* (math:cosh r) (math:sin i)))))

(defun cosh
  (((match-complex real r img i))
   (complex:new (* (math:cosh r) (math:cos i))
                (* -1 (math:sinh r) (math:sin i)))))

(defun tanh (z)
  (/ (sinh z)
     (cosh z)))

(defun csch (z)
  (/ 1 (sinh z)))

(defun sech (z)
  (/ (cosh z)))

(defun coth (z)
  (/ (tanh z)))

;; Inverse trigonometric functions