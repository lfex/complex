(defmodule cmplx-ops
  (export (one 0)
          (i 0)
          (sign 1)
          (neg 1)
          (eq 2)
          (eq 3)
          (eeq 2)
          (conj 1)
          (modsq 1)
          (modulus 1) (modulus 2)
          (abs 1) (abs 2)
          (inv 1)
          (arg 1) (arg 2)
          (phase 1)
          (sqrt 1))
  (import (from complex
                (complex 2)
                (add 2)
                (sub 2)
                (mult 2)
                (div 2)
                (real 1))))

(include-lib "complex/include/data-types.lfe")
(include-lib "complex/include/options.lfe")

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
   (complex (* -1 r) (* -1 i))))

;; Equality:
;;
;; > (complex:eq z1 z2)
;; false
;; > (complex:eq z1 (complex:new 1 2))
;; true

(defun eq
  "Equal."
  (((match-complex real r1 img i1)
    (match-complex real r2 img i2))
   (if (and (== r1 r2)
            (== i1 i2))
     'true
     'false)))

(defun eq
  "Equal, within a tolerance.

  Sometimes it's useful to set a tolerance level for what floating points
  numbers should be considered 0. This is done in the unit tests for this
  library, assuming any float less that 1.0e-15 to be a zero, e.g. The
  following version of the equality function take an options list or
  options record, and if the field 'tol' is present and set to something
  other than 'undefined', a tolerance check will be performed."
  ((z1 z2 '())
   (eq z1 z2))
  ((z1 z2 opts) (when (is_list opts))
   (eq z1 z2 (opts->rec opts)))
  ((z1 z2 (match-opts tol 'undefined))
   (eq z1 z2))
  (((match-complex real r1 img i1)
    (match-complex real r2 img i2)
    (match-opts tol tol))
   (if (and (== (complex:zero-check r1 tol)
                (complex:zero-check r2 tol))
            (== (complex:zero-check i1 tol)
                (complex:zero-check i2 tol)))
     'true
     'false))
  ((z1 z2 _)
   (eq z1 z2)))

(defun eeq
  "Exactly equal."
  (((match-complex real r1 img i1)
    (match-complex real r2 img i2))
   (if (and (=:= r1 r2)
            (=:= i1 i2))
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
   (complex r (* -1 i))))

(defun modsq (z)
  (mult z (conj z)))

(defun modulus (z)
  (math:sqrt (real (modsq z))))

(defun modulus
  ((z #(complex))
   (complex (modulus z) 0)))

(defun abs (z)
  (modulus z))

(defun abs (z opt)
  (modulus z opt))

;; Inverse:
;;
;; > (complex:inv z1)
;; #(complex 0.2 -0.4)
;; > (complex:inv z2)
;; #(complex 0.08823529411764706 0.14705882352941177)

(defun inv (z)
  (div (conj z) (modsq z)))

(defun arg
  (((match-complex real r img i))
   (arg r i)))

(defun arg
  ;; ((r i) (when (> r 0))
  ;;  (math:atan2 i r))
  ;; ((r i) (when (and (< r 0) (< i 0)))
  ;;  (- (math:atan2 i r) (math:pi)))
  ;; ((r i) (when (and (< r 0) (>= i 0)))
  ;;  (+ (math:atan2 i r) (math:pi)))
  ((r i) (when (andalso (== r 0) (== i 0)))
   'undefined)
  ((r i)
   (math:atan2 i r))
  ;; ((r i) (when (and (== r 0) (> i 0)))
  ;;  (/ (math:pi) 2))
  ;; ((r i) (when (and (== r 0) (< i 0)))
  ;;  (/ (math:pi -2)))
  )

(defun phase (z)
  (arg z))

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
     (complex r2 i2))))

