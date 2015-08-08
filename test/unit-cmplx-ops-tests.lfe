(defmodule unit-cmplx-ops-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")

(deftest eq
  (is (complex:eq (unit-cmplx-tests:c1)
                  (unit-cmplx-tests:c1)))
  (is (complex:eq (unit-cmplx-tests:c2)
                  (unit-cmplx-tests:c2)))
  (is-not (complex:eq (unit-cmplx-tests:c1)
                      (unit-cmplx-tests:c2)))
  (is-not (complex:eq (unit-cmplx-tests:c3)
                      (unit-cmplx-tests:c4))))

(deftest conj
  (is-equal #(complex 1 -2) (complex:conj (unit-cmplx-tests:c1)))
  (is-equal #(complex 3 5) (complex:conj (unit-cmplx-tests:c2)))
  (is-equal #(complex -1 0) (complex:conj (unit-cmplx-tests:c3)))
  (is-equal #(complex -4 2) (complex:conj (unit-cmplx-tests:c4))))

(deftest modulus
  (is-equal #(complex 5 0) (complex:modulus (unit-cmplx-tests:c1)))
  (is-equal #(complex 34 0) (complex:modulus (unit-cmplx-tests:c2)))
  (is-equal #(complex 1 0) (complex:modulus (unit-cmplx-tests:c3)))
  (is-equal #(complex 20 0) (complex:modulus (unit-cmplx-tests:c4))))

(deftest abs
  (is-equal 2.23606797749979 (complex:abs (unit-cmplx-tests:c1)))
  (is-equal 5.830951894845301 (complex:abs (unit-cmplx-tests:c2)))
  (is-equal 1.0 (complex:abs (unit-cmplx-tests:c3)))
  (is-equal 4.47213595499958 (complex:abs (unit-cmplx-tests:c4))))

(deftest inv
  (is-equal #(complex 0.2 -0.4) (complex:inv (unit-cmplx-tests:c1)))
  (is-equal #(complex -1.0 0.0) (complex:inv (unit-cmplx-tests:c3)))
  (is-equal #(complex -0.2 0.1) (complex:inv (unit-cmplx-tests:c4))))

(deftest sqrt
  (is-equal #(complex 1.272019649514069 0.7861513777574233)
            (complex:sqrt (unit-cmplx-tests:c1)))
  (is-equal #(complex 2.101303392521568 -1.1897377641407583)
            (complex:sqrt (unit-cmplx-tests:c2)))
  (is-equal #(complex 0.0 1.0)
            (complex:sqrt (unit-cmplx-tests:c3)))
  (is-equal #(complex 0.48586827175664576 -2.0581710272714924)
            (complex:sqrt (unit-cmplx-tests:c4))))