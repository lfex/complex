(defmodule unit-cmplx-util-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")

(deftest ->str
  (is-equal '("1" 32 "+" "2" 105)
            (complex:->str (unit-cmplx-tests:c1)))
  (is-equal '("3" 32 "" "-5" 105)
            (complex:->str (unit-cmplx-tests:c2)))
  (is-equal '("-1" 32 "+" "0" 105)
            (complex:->str (unit-cmplx-tests:c3)))
  (is-equal '("-4" 32 "" "-2" 105)
            (complex:->str (unit-cmplx-tests:c4))))