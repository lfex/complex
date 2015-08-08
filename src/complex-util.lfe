(defmodule complex-util
  (export all))

(defun get-version ()
  (lutil:get-app-version 'complex))

(defun get-versions ()
  (++ (lutil:get-versions)
      `(#(complex ,(get-version)))))
