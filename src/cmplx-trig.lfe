(defmodule cmplx-trig
  (export (cos 1) (cos 2)
          (sin 1) (sin 2)
          (tan 1) (tan 2)
          (csc 1) (csc 2)
          (sec 1) (sec 2)
          (cot 1) (cot 2)
          ;; XXX these are broken right now
          ;; (cosh 1)
          ;; (sinh 1)
          ;; (tanh 1)
          ;; (csch 1)
          ;; (sech 1)
          ;; (coth 1)
          ))

(include-lib "complex/include/data-types.lfe")
(include-lib "complex/include/options.lfe")

;; Trigonometric functions

(defun sin (z)
  (sin z '()))

(defun cos (z)
  (sin z '()))

(defun tan (z)
  (tan z '()))

(defun csc (z)
  (csc z '()))

(defun sec (z)
  (sec z '()))

(defun cot (z)
  (cot z '()))

(defun sin
  (((match-complex real r img i) opts)
   (complex:new (* (math:sin r) (math:cosh i))
                (* (math:cos r) (math:sinh i))
                (opts->rec opts))))

(defun cos
  (((match-complex real r img i) opts)
   (complex:new (* (math:cos r) (math:cosh i))
                (* -1 (math:sin r) (math:sinh i))
                (opts->rec opts))))

(defun tan (z opts)
  (complex:div (sin z opts)
               (cos z opts)))

(defun csc (z opts)
  (complex:div (complex:one)
               (sin z opts)))

(defun sec (z opts)
  (complex:div (complex:one)
               (cos z opts)))

(defun cot (z opts)
  (complex:div (complex:one)
               (tan z opts)))

;; Hyperbolic trigonometric functions

;; XXX these are broken right now

;; (defun sinh
;;   (((match-complex real r img i))
;;    (complex:new (* (math:sinh r) (math:cos i))
;;                 (* (math:cosh r) (math:sin i)))))

;; (defun cosh
;;   (((match-complex real r img i))
;;    (complex:new (* (math:cosh r) (math:cos i))
;;                 (* -1 (math:sinh r) (math:sin i)))))

;; (defun tanh (z)
;;   (complex:div (sinh z)
;;                (cosh z)))

;; (defun csch (z)
;;   (complex:div 1
;;                (sinh z)))

;; (defun sech (z)
;;   (complex:div 1
;;                (cosh z)))

;; (defun coth (z)
;;   (complex:div 1
;;                (tanh z)))

;; Inverse trigonometric functions
