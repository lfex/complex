(defmodule cmplx-exp
  (export (pow 2)
          (exp 1)
          (ln 1))
  (import (from complex
                (complex 2)
                (add 2)
                (sub 2)
                (mult 2)
                (div 2)
                (one 0)
                (i 0)
                (modulus 1)
                (arg 1)
                (sqrt 1)
                (rect->polar 1)
                (complex? 1)
                (complex-polar? 1))))

(include-lib "complex/include/data-types.lfe")

(defun pow
  ((z n) (when (== n 0))
   (complex:one))
  ((z n) (when (is_integer z))
   (complex:new (math:pow z n) 0))
  ((z n) (when (>= n 1))
   (positive-integer-powers z n))
  ((z n) (when (and (> n -1) (< n 1)))
   (root z n))
  ((z n) (when (=< n -1))
   (negative-integer-powers z n)))

(defun positive-integer-powers (z n)
  (lists:foldl (lambda (x acc)
                 (mult x acc))
               (one)
               (lists:duplicate n z)))

(defun negative-integer-powers (z n)
  (complex:div (one)
               (positive-integer-powers z (abs n))))

(defun root (z n)
  (cond
   ((complex? z)
    (root-rect z n))
   ((complex-polar? z)
    (root-polar z n))
   ('true
    (complex:new (math:pow z n) 0))))

(defun root-rect
  ((z 0.5)
   (complex:sqrt z))
  ((z n)
   (root-polar (rect->polar z) n)))

(defun root-polar
  (((match-complex-polar mod r arg phi) n)
   (mult (complex (math:pow r n) 0)
         (complex (math:cos (* phi n))
                  (math:sin (* phi n))))))

(defun exp
  (((match-complex real r img i))
   (complex (* (math:exp r) (math:cos i))
            (* (math:exp r) (math:sin i)))))

(defun ln
  (((= (match-complex real r img i) z))
   (complex (math:log (modulus z))
            (arg z))))