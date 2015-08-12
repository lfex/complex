(defmodule cmplx-const
  (export (one 0)
          (-one 0)
          (two 0)
          (-two 0)
          (i 0)
          (-i 0)
          (i/2 0)
          (-i/2 0)
          (e 0)
          (pi 0)
          (-pi 0)
          (pi/2 0)
          (-pi/2 0)
          (2pi 0)
          (-2pi 0))
  (import (from complex
                (complex 2))))

(defun one ()
  (complex 1 0))

(defun -one ()
  (complex -1 0))

(defun two ()
  (complex 2 0))

(defun -two ()
  (complex -2 0))

(defun i ()
  (complex 0 1))

(defun -i ()
  (complex 0 -1))

(defun i/2 ()
  (complex 0 0.5))

(defun -i/2 ()
  (complex 0 -0.5))

(defun e ()
  (complex (math:exp 1) 0))

(defun pi ()
  (complex (math:pi) 0))

(defun -pi ()
  (complex (* -1 (math:pi)) 0))

(defun pi/2 ()
  (complex (* (math:pi) 0.5) 0))

(defun -pi/2 ()
  (complex (* (math:pi) -0.5) 0))

(defun 2pi ()
  (complex (* (math:pi) 2) 0))

(defun -2pi ()
  (complex (* (math:pi) -2) 0))
