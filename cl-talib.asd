;;;; cl-talib.asd

(asdf:defsystem #:cl-talib
  :description "talib in common lisp"
  :author "xizang123321@gmail.com"
  :license  "MIT"
  :version "0.0.1"
  :serial t
  :depends-on (#:cl-autowrap)
  :components ((:file "package")
               (:file "cl-talib")
	       (:file "example")
	       (:module #:include
                :pathname "include"
                :components ((:static-file "ta_abstract.h")
			     (:static-file "ta_common.h")
			     (:static-file "ta_defs.h")
			     (:static-file "ta_func.h")
			     (:static-file "ta_libc.h")))
	       
	       (:module #:specs
                :pathname "specs")))
