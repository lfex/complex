(defmodule unit-cmplx-arith-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")

(deftest add
  (is-equal #(complex 4 -3)
            (complex:add (unit-cmplx-tests:c1)
                         (unit-cmplx-tests:c2)))
  (is-equal #(complex -5 -2)
            (complex:add (unit-cmplx-tests:c3)
                         (unit-cmplx-tests:c4))))

(deftest sub
  (is-equal #(complex -2 7)
            (complex:sub (unit-cmplx-tests:c1)
                         (unit-cmplx-tests:c2)))
  (is-equal #(complex 3 2)
            (complex:sub (unit-cmplx-tests:c3)
                         (unit-cmplx-tests:c4))))

(deftest mult
  (is-equal #(complex 13 1)
            (complex:mult (unit-cmplx-tests:c1)
                          (unit-cmplx-tests:c2)))
  (is-equal #(complex 4 2)
            (complex:mult (unit-cmplx-tests:c3)
                          (unit-cmplx-tests:c4))))

(deftest div
  (is-equal #(complex 1.0 0.0)
            (complex:div (unit-cmplx-tests:c1)
                         (unit-cmplx-tests:c1)))
  (is-equal #(complex 1.0 0.0)
            (complex:div (unit-cmplx-tests:c4)
                         (unit-cmplx-tests:c4)))
  (is-equal #(complex -0.1 1.3)
            (complex:div (unit-cmplx-tests:c2)
                         (unit-cmplx-tests:c4)))
  (is-equal #(complex 0.2 -0.1)
            (complex:div (unit-cmplx-tests:c3)
                         (unit-cmplx-tests:c4))))