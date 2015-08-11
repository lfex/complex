(defmodule cmplx
  (export (new 0) (new 1) (new 2) (complex 2)
          (new-polar 0) (new-polar 1) (new-polar 2) (complex-polar 2)
          (complex? 1)
          (complex-polar? 1)
          (real 1)
          (img 1)
          (r 1) (distance 1)
          (phi 1) (angle 1)))

(include-lib "complex/include/data-types.lfe")
(include-lib "complex/include/options.lfe")

(defun new ()
  (new 0 0))

(defun new
  ((z-str) (when (is_list z-str))
   (cmplx-util:str-> z-str))
  ((z-atom) (when (is_atom z-atom))
   (cmplx-util:atom-> z-atom))
  ((r)
   (new r 0)))

(defun new (r i)
  (make-complex real r img i))

(defun complex (r i)
  "This function is an alias for new/2 and is provided for aesthetic reasons:
  it will look nicer in the REPL calling (complex 1 2) than (new 1 2)."
  (new r i))

(defun new-polar ()
  (new-polar 1 0))

(defun new-polar (phi)
  (new-polar 1 phi))

(defun new-polar (r phi)
  (make-complex-polar r r phi phi))

(defun complex-polar (r phi)
  (new-polar r phi))

(defun complex? (z)
  (is-complex z))

(defun complex-polar? (z-polar)
  (is-complex-polar z-polar))

(defun real (z)
  (complex-real z))

(defun img (z)
  (complex-img z))

(defun r (z-polar)
  (complex-polar-r z-polar))

(defun distance (z-polar)
  (r z-polar))

(defun phi (z-polar)
  (complex-polar-phi z-polar))

(defun angle (z-polar)
  (phi z-polar))
