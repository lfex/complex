(defmodule cmplx-ops
  (export (one 0)
          (i 0)
          (sign 1)
          (neg 1)
          (eq 2)
          (conj 1)
          (modulus 1)
          (abs 1) (abs 2)
          (inv 1)
          (sqrt 1)))

(include-lib "complex/include/data-types.lfe")

(defun one ()
  (complex:new 1 0))

(defun i ()
  (complex:new 0 1))

(defun sign
  ((x) (when (< x 0))
   -1)
  ((_)
   1))

;; Negation:
;;
;; > (complex:neg z1)
;; #(complex -1 -2)
;; > (complex:neg z2)
;; #(complex -3 5)

(defun neg
  (((match-complex real r img i))
   (complex:new (* -1 r) (* -1 i))))

;; Equality:
;;
;; > (complex:eq z1 z2)
;; false
;; > (complex:eq z1 (complex:new 1 2))
;; true

(defun eq
  (((match-complex real r1 img i1)
    (match-complex real r2 img i2))
   (if (and (=:= (float r1) (float r2))
            (=:= (float i1) (float i2)))
     'true
     'false)))

;; Conjugate:
;;
;; > (complex:conj z1)
;; #(complex 1 -2)
;; > (complex:conj z2)
;; #(complex 3 5)

(defun conj
  (((match-complex real r img i))
   (complex:new r (* -1 i))))

(defun modulus (z)
  (cmplx-arith:mult z (conj z)))

(defun abs (z)
  (math:sqrt (complex-real (modulus z))))

(defun abs
  ((z #(complex))
   (complex:new (abs z) 0)))

;; Inverse:
;;
;; > (complex:inv z1)
;; #(complex 0.2 -0.4)
;; > (complex:inv z2)
;; #(complex 0.08823529411764706 0.14705882352941177)

(defun inv (z)
  (complex:div (conj z) (modulus z)))

;; Square Root:
;;
;; > (complex:sqrt (complex:new -1 0))
;; #(complex 0.0 1.0)
;; > (complex:sqrt z1)
;; #(complex 1.7320508075688772 1.4142135623730951)
;; > (complex:sqrt z2)
;; #(complex 4.301162633521313 -3.9370039370059056)

(defun sqrt
  (((= (match-complex real r img i) z))
   (let* ((abs-z (abs z))
          (neg-r (* -1 r))
          (r2 (math:sqrt (/ (+ r abs-z) 2)))
          (i2 (* (sign i) (math:sqrt (/ (+ neg-r abs-z) 2)))))
     (complex:new r2 i2))))

