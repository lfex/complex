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
;; > (complex:neg c1)
;; #(complex -1 -2)
;; > (complex:neg c2)
;; #(complex -3 5)

(defun neg
  (((match-complex real r img i))
   (complex:new (* -1 r) (* -1 i))))

;; Equality:
;;
;; > (complex:eq c1 c2)
;; false
;; > (complex:eq c1 (complex:new 1 2))
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
;; > (complex:conj c1)
;; #(complex 1 -2)
;; > (complex:conj c2)
;; #(complex 3 5)

(defun conj
  (((match-complex real r img i))
   (complex:new r (* -1 i))))

(defun modulus (cmplx)
  (cmplx-arith:mult cmplx (conj cmplx)))

(defun abs (cmplx)
  (math:sqrt (complex-real (modulus cmplx))))

(defun abs
  ((cmplx #(complex))
   (complex:new (abs cmplx) 0)))

;; Inverse:
;;
;; > (complex:inv c1)
;; #(complex 0.2 -0.4)
;; > (complex:inv c2)
;; #(complex 0.08823529411764706 0.14705882352941177)

(defun inv (cmplx)
  (complex:div (conj cmplx) (modulus cmplx)))

;; Square Root:
;;
;; > (complex:sqrt (complex:new -1 0))
;; #(complex 0.0 1.0)
;; > (complex:sqrt c1)
;; #(complex 1.7320508075688772 1.4142135623730951)
;; > (complex:sqrt c2)
;; #(complex 4.301162633521313 -3.9370039370059056)

(defun sqrt
  (((= (match-complex real r img i) c))
   (let* ((abs-c (abs c))
          (neg-r (* -1 r))
          (r2 (math:sqrt (/ (+ r abs-c) 2)))
          (i2 (* (sign i) (math:sqrt (/ (+ neg-r abs-c) 2)))))
     (complex:new r2 i2))))

