(defmodule cmplx-trig
  (export (cos 1) (cosh 1) (acos 1) (acosh 1)
          (sin 1) (sinh 1) (asin 1) (asinh 1)
          (tan 1) (tanh 1) (atan 1) (atanh 1)
          (csc 1) (csch 1) (acsc 1) (acsch 1)
          (sec 1) (sech 1) (asec 1) (asech 1)
          (cot 1) (coth 1) (acot 1) (acoth 1))
  (import (from complex
                (complex 2)
                (add 2)
                (sub 2)
                (mult 2)
                (div 2)
                (one 0)
                (two 0)
                (-two 0)
                (i 0)
                (-i 0)
                (i/2 0)
                (ln 1)
                (sqrt 1)
                (pow 2))))

(include-lib "complex/include/data-types.lfe")
(include-lib "complex/include/options.lfe")

;; Trigonometric functions

(defun sin
  (((match-complex real r img i))
   (complex (* (math:sin r) (math:cosh i))
            (* (math:cos r) (math:sinh i)))))

(defun cos
  (((match-complex real r img i))
   (complex (* (math:cos r) (math:cosh i))
            (* -1 (math:sin r) (math:sinh i)))))

(defun tan (z)
  (div (sin z)
       (cos z)))

(defun csc (z)
  (div (one)
       (sin z)))

(defun sec (z)
  (div (one)
       (cos z)))

(defun cot (z)
  (div (one)
       (tan z)))

;; Hyperbolic trigonometric functions

(defun sinh
  (((match-complex real r img i))
   (complex (* (math:sinh r) (math:cos i))
            (* (math:cosh r) (math:sin i)))))

(defun cosh
  (((match-complex real r img i))
   (complex (* (math:cosh r) (math:cos i))
            (* -1 (math:sinh r) (math:sin i)))))

(defun tanh (z)
  (div (sinh z)
       (cosh z)))

(defun csch (z)
  (div (one)
       (sinh z)))

(defun sech (z)
  (div (one)
       (cosh z)))

(defun coth (z)
  (div (one)
       (tanh z)))

;; Inverse trigonometric functions

(defun asin (z)
  (mult
   (-i)
   (ln (add (mult z (i))
            (sqrt
             (sub (one) (pow z 2)))))))

(defun acos (z)
  (mult
   (-i)
   (ln (add z (mult (i)
                    (sqrt
                     (sub (one)
                          (pow z 2))))))))

(defun atan (z)
  (mult
   (i/2)
   (ln (div (add (i) z)
            (sub (i) z)))))

(defun acsc (z)
  (mult
   (-i)
   (ln (add (div (i) z)
            (sqrt (sub (one)
                       (div (one)
                            (pow z 2))))))))

(defun asec (z)
  (mult
   (i)
   (ln (div (add (one)
                 (sqrt
                  (sub (one) (pow z 2))))
            z))))

(defun acot (z)
  (sub
   (mult
    (i/2)
    (ln (sub (one) (div (i) z))))
   (mult
    (i/2)
    (ln (add (one) (div (i) z))))))

;; Inverse hyperbolic trigonometric functions

(defun asinh (z)
  (ln (add z
           (sqrt
            (add (one) (pow z 2))))))

(defun acosh (z)
  (ln (add z (mult
              (sqrt (sub z (one)))
              (sqrt (add z (one)))))))

(defun atanh (z)
  (add
   (div (ln (sub (one) z))
        (-two))
   (div (ln (add (one) z))
        (two))))

(defun acsch (z)
  (ln (add
       (sqrt (add (one)
                  (div (one)
                       (pow z 2))))
       (div (one) z))))

(defun asech (z)
  (ln (add
       (mult
        (sqrt (sub
               (div (one) z)
               (one)))
        (sqrt (add
               (div (one) z)
               (one))))
       (div (one) z))))

(defun acoth (z)
  (add
   (div (ln (sub (one)
                 (div (one) z)))
        (-two))
   (div (ln (add (one)
                 (div (one) z)))
        (two))))