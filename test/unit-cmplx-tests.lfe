(defmodule unit-cmplx-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")

(defun c1 () (complex:new 1 2))
(defun c2 () (complex:new 3 -5))
(defun c3 () (complex:new -1 0))
(defun c4 () (complex:new -4 -2))
(defun c5 () (complex:new))
(defun c6 () (complex:new 4))

(deftest new-1
  (is-equal #(complex 0 0) (c5))
  (is-equal (c1) (complex:new "1 2i"))
  (is-equal (c2) (complex:new "3 -5i"))
  (is-equal (c3) (complex:new "-1"))
  (is-equal (c4) (complex:new "-4 -2i"))
  (is-equal #(complex 0 2) (complex:new "2i")))

(deftest new-2
  (is-equal #(complex 4 0) (c6)))

(deftest new-3
  (is-equal #(complex -4 -2) (c4)))
