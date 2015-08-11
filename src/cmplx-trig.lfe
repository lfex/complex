(defmodule cmplx-trig
  (export (cos 1) (cosh 1) (acos 1)
          (sin 1) (sinh 1) (asin 1)
          (tan 1) (tanh 1) (atan 1)
          (csc 1) (csch 1) (acsc 1)
          (sec 1) (sech 1) (asec 1)
          (cot 1) (coth 1) (acot 1)))

(include-lib "complex/include/data-types.lfe")
(include-lib "complex/include/options.lfe")

;; Trigonometric functions

(defun sin
  (((match-complex real r img i))
   (complex:new (* (math:sin r) (math:cosh i))
                (* (math:cos r) (math:sinh i)))))

(defun cos
  (((match-complex real r img i))
   (complex:new (* (math:cos r) (math:cosh i))
                (* -1 (math:sin r) (math:sinh i)))))

(defun tan (z)
  (complex:div (sin z)
               (cos z)))

(defun csc (z)
  (complex:div (complex:one)
               (sin z)))

(defun sec (z)
  (complex:div (complex:one)
               (cos z)))

(defun cot (z)
  (complex:div (complex:one)
               (tan z)))

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
  (complex:div (sinh z)
               (cosh z)))

(defun csch (z)
  (complex:div (complex:one)
               (sinh z)))

(defun sech (z)
  (complex:div (complex:one)
               (cosh z)))

(defun coth (z)
  (complex:div (complex:one)
               (tanh z)))

;; Inverse trigonometric functions

(defun asin (z)
  (complex:mult
   (complex:new 0 -1)
   (complex:ln
    (complex:add (complex:mult z
                               (complex:i))
                 (complex:sqrt
                  (complex:sub (complex:one)
                               (complex:pow z 2)))))))

(defun acos (z)
  (complex:mult
   (complex:new 0 -1)
   (complex:ln
    (complex:add z
                 (complex:mult
                  (complex:i)
                  (complex:sqrt
                   (complex:sub (complex:one)
                                (complex:pow z 2))))))))

(defun atan (z)
  (complex:mult
   (complex:new 0 0.5)
   (complex:ln
    (complex:div (complex:add (complex:i)
                              z)
                 (complex:sub (complex:i)
                              z)))))

(defun acsc (z)
  (complex:mult
   (complex:new 0 -1)
   (complex:ln
    (complex:add
     (complex:div (complex:i)
                  z)
     (complex:sqrt
      (complex:sub (complex:one)
                   (complex:div (complex:one)
                                (complex:pow z 2))))))))

(defun asec (z)
  (complex:mult
   (complex:i)
   (complex:ln
    (complex:div (complex:add (complex:one)
                              (complex:sqrt
                               (complex:sub (complex:one)
                                            (complex:pow z 2))))
                 z))))

(defun acot (z)
  (complex:sub
   (complex:mult
    (complex:new 0 0.5)
    (complex:ln (complex:sub
                 (complex:one) (complex:div
                                (complex:i) z))))
   (complex:mult
    (complex:new 0 0.5)
    (complex:ln (complex:add
                 (complex:one) (complex:div
                                (complex:i) z))))))