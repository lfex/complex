(defmodule unit-cmplx-util-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")

(deftest ->str
  (is-equal '("1" "+" "2" #\i)
            (cmplx-util:->str (unit-cmplx-tests:c1)))
  (is-equal '("3" "" "-5" #\i)
            (cmplx-util:->str (unit-cmplx-tests:c2)))
  (is-equal '("-1" "+" "0" #\i)
            (cmplx-util:->str (unit-cmplx-tests:c3)))
  (is-equal '("-4" "" "-2" #\i)
            (cmplx-util:->str (unit-cmplx-tests:c4)))
  (is-equal '("0" "+" "5" #\i)
            (cmplx-util:->str (unit-cmplx-tests:c7))))

(deftest str->real
  (is-equal #(complex 1 0) (cmplx-util:str-> "1"))
  (is-equal #(complex 10 0) (cmplx-util:str-> "10"))
  (is-equal #(complex -1 0) (cmplx-util:str-> "-1"))
  (is-equal #(complex -10 0) (cmplx-util:str-> "-10"))
  (is-equal #(complex 1 0) (cmplx-util:str-> "+1"))
  (is-equal #(complex 10 0) (cmplx-util:str-> "+10"))
  (is-equal #(complex 1.2 0) (cmplx-util:str-> "1.2"))
  (is-equal #(complex 1.2e200 0) (cmplx-util:str-> "1.2e200"))
  (is-equal #(complex 1.2e200 0) (cmplx-util:str-> "1.2e+200"))
  (is-equal #(complex 1.2e-200 0) (cmplx-util:str-> "1.2e-200"))
  (is-equal #(complex 1.2e200 0) (cmplx-util:str-> "1.2E200"))
  (is-equal #(complex 1.2e200 0) (cmplx-util:str-> "1.2E+200"))
  (is-equal #(complex 1.2e-200 0) (cmplx-util:str-> "1.2E-200")))

(deftest str->img
  (is-equal #(complex 0 1) (cmplx-util:str-> "0+1i"))
  (is-equal #(complex 0 10) (cmplx-util:str-> "0+10i"))
  (is-equal #(complex 0 -1) (cmplx-util:str-> "0-1i"))
  (is-equal #(complex 0 -10) (cmplx-util:str-> "0-10i"))
  (is-equal #(complex 0 1.2) (cmplx-util:str-> "0+1.2i"))
  (is-equal #(complex 0 1.2e200) (cmplx-util:str-> "0+1.2e200i"))
  (is-equal #(complex 0 1.2e200) (cmplx-util:str-> "0+1.2e+200i"))
  (is-equal #(complex 0 1.2e-200) (cmplx-util:str-> "0+1.2e-200i"))
  (is-equal #(complex 0 1) (cmplx-util:str-> "0+1j"))
  (is-equal #(complex 0 2) (cmplx-util:str-> "0+2I"))
  (is-equal #(complex 0 3) (cmplx-util:str-> "0+3J")))

(deftest str->complex
  (is-equal #(complex 4 2) (cmplx-util:str-> "4+2i"))
  (is-equal #(complex -4 -2) (cmplx-util:str-> "-4-2i"))
  (is-equal #(complex 4 2) (cmplx-util:str-> "+4+2i"))
  (is-equal #(complex 1.2 -3.4) (cmplx-util:str-> "1.2-3.4i"))
  (is-equal #(complex 1.2e3 -4.5e-6) (cmplx-util:str-> "1.2e3-4.5e-6i")))
