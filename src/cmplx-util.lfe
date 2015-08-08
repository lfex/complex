(defmodule cmplx-util
  (export (get-version 0)
          (get-versions 0)
          (->str 1) (->str 3)
          (print-api-functions 0)))

(include-lib "complex/include/data-types.lfe")

(defun get-version ()
  (lutil:get-app-version 'complex))

(defun get-versions ()
  (++ (lutil:get-versions)
      `(#(complex ,(get-version)))))

;; Convert to string (list):
;;
;; > (complex:->str c1)
;; ("1" 32 "+" "2" 105)
;; > (complex:->str c2)
;; ("3" 32 () "-5" 105)

(defun ->str
  (((match-complex real r img i)) (when (>= i 0))
   (->str r i "+"))
  (((match-complex real r img i))
   (->str r i "")))

(defun ->str (r i pos)
  (io_lib:format "~p ~s~pi" `(,r ,pos ,i)))

(defun check-function
  ((`#(,func-name ,arity))
   (let ((skip '(module_info
                 get-version
                 get-versions
                 loaded-complex-data-types
                 loaded-complex-api
                 loaded-complex
                 print-api-functions)))
     (if (lists:member func-name skip)
       'false
       `#(true #(,func-name ,arity))))))

(defun get-api-functions ()
  (lists:filtermap
   #'check-function/1
   (proplists:get_value 'exports (complex:module_info))))

(defun print-function
  ((`#(,func-name ,arity))
   (lfe_io:format "complex:~p/~p~n" `(,func-name ,arity))))

(defun print-api-functions ()
  (lists:foreach #'print-function/1 (get-api-functions)))