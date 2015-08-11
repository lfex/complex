(defmodule cmplx-arith
  (export (add 2)
          (sub 2)
          (mult 2)
          (div 2)))

(include-lib "complex/include/data-types.lfe")

;; Setup:
;;
;; > (set z1 (complex:new 1 2))
;; #(complex 1 2)
;; > (set z2 (complex:new 3 -5))
;; #(complex 3 -5)

;; Adding:
;;
;; > (complex:add z1 z2)
;; #(complex 4 -3)
;;
(defun add
  (((match-complex real r1 img i1)
    (match-complex real r2 img i2))
   (complex:new (+ r1 r2) (+ i1 i2))))

;; Subtracting:
;;
;; > (complex:sub z1 z2)
;; #(complex -2 7)
;; > (complex:sub z2 z1)
;; #(complex 2 -7)
;; > (complex:sub z1 z1)
;; #(complex 0 0)
;;
(defun sub
  (((match-complex real r1 img i1)
    (match-complex real r2 img i2))
   (complex:new (- r1 r2) (- i1 i2))))

;; Multiplying
;;
;; > (complex:* z1 z2)
;; #(complex 13 -11)
;;
(defun mult
  (((match-complex real r1 img i1)
    (match-complex real r2 img i2))
   (complex:new (- (* r1 r2) (* i1 i2))
                (+ (* r1 i2) (* r2 i1)))))

;; Division:
;;
;; > (complex:div z1 z2)
;; #(complex -0.20588235294117646 0.3235294117647059)
;; > (complex:div z2 z1)
;; #(complex -1.4 -2.2)
;;
(defun div (z1 z2)
  (let* ((denom (complex:real (complex:modsq z2)))
         (z3 (mult z1 (complex:conj z2))))
    (complex:new (/ (complex:real z3) denom)
                 (/ (complex:img z3) denom))))