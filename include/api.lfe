(defmacro generate-cmplx-api-wrappers ()
  `(progn ,@(kla:wrap-mod-funcs 'cmplx)
          ,@(kla:wrap-mod-funcs 'cmplx-arith)
          ,@(kla:wrap-mod-funcs 'cmplx-exp)
          ,@(kla:wrap-mod-funcs 'cmplx-ops)
          ,@(kla:wrap-mod-funcs 'cmplx-io)
          ,@(kla:wrap-mod-funcs 'cmplx-util)))

(generate-cmplx-api-wrappers)

(defun loaded-complex-api ()
  "This is just a dummy function for display purposes when including from the
  REPL (the last function loaded has its name printed in stdout).
  This function needs to be the last one in this include."
  'ok)