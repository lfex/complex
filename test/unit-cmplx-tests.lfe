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
(defun c7 () (complex:new 0 5))
(defun c8 () (complex:new 1 1))
(defun c9 () (complex:new 0 -5))
(defun c10 () (complex:new 1 0))
  
(deftest mew-no-args
  (is-equal #(complex 0 0) (c5)))

(deftest new-basic
  (is-equal (c1) (complex:new "1+2i"))
  (is-equal (c2) (complex:new "3-5i"))
  (is-equal (c1) (complex:new '1+2i))
  (is-equal (c2) (complex:new '3-5i))
  (is-equal #(complex -4 -2) (c4))
  (is-equal (c4) (complex:new '-4-2i)))

(deftest new-no-img
  (is-equal #(complex 4 0) (c6))
  (is-equal (c10) (complex:new "1")))

(deftest new-no-img-plus-sign
  (is-equal (c10) (complex:new "+1"))
  (is-equal (c10) (complex:new "+1+0i")))

(deftest new-no-img-minus-sign
  (is-equal (c3) (complex:new "-1"))
  (is-equal (c3) (complex:new '-1)))

(deftest new-no-real
  (is-equal #(complex 0 2) (complex:new "0+2i"))
  (is-equal #(complex 0 2) (complex:new '0+2i))
  (is-equal (c7) (complex:new "5i"))
  (is-equal (c7) (complex:new '5i))
  (is-equal (c9) (complex:new "0-5i")))

(deftest new-no-real-plus-sign
  (is-equal (c7) (complex:new "+5i"))
  (is-equal (c7) (complex:new '+5i))
  (is-equal (c7) (complex:new "+0+5i")))

(deftest new-no-real-minus-sign
  (is-equal (c9) (complex:new "-5i"))
  (is-equal (c9) (complex:new '-5i))
  (is-equal (c9) (complex:new "-0-5i"))
  (is-equal (c9) (complex:new "+0-5i")))
