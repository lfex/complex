(defmodule cmplx-arith
  (export (add 2)
          (sub 2)
          (mult 2)
          (div 2)))

(include-lib "complex/include/data-types.lfe")

;; Setup:
;;
;; > (set c1 (complex:new 1 2))
;; #(complex 1 2)
;; > (set c2 (complex:new 3 -5))
;; #(complex 3 -5)

;; Adding:
;;
;; > (complex:add c1 c2)
;; #(complex 4 -3)
;;
(defun add
  (((match-complex real r1 img i1)
    (match-complex real r2 img i2))
   (complex:new (+ r1 r2) (+ i1 i2))))

;; Subtracting:
;;
;; > (complex:sub c1 c2)
;; #(complex -2 7)
;; > (complex:sub c2 c1)
;; #(complex 2 -7)
;; > (complex:sub c1 c1)
;; #(complex 0 0)
;;
(defun sub
  (((match-complex real r1 img i1)
    (match-complex real r2 img i2))
   (complex:new (- r1 r2) (- i1 i2))))

;; Multiplying
;;
;; > (complex:* c1 c2)
;; #(complex 13 -11)
;;
(defun mult
  (((match-complex real r1 img i1)
    (match-complex real r2 img i2))
   (complex:new (- (* r1 r2) (* i1 i2))
                (+ (* r1 i2) (* r2 i1)))))

;; Division:
;;
;; > (complex:div c1 c2)
;; #(complex -0.20588235294117646 0.3235294117647059)
;; > (complex:div c2 c1)
;; #(complex -1.4 -2.2)
;;
(defun div (c1 c2)
  (let* ((denom (complex-real (cmplx-ops:modulus c2)))
         (c3 (mult c1 (cmplx-ops:conj c2))))
    (complex:new (/ (complex-real c3) denom)
                 (/ (complex-img c3) denom))))