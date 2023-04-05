# cl-talib
Talib library binding in common lisp

Install:
clone git@github.com:anranyicheng/cl-talib.git to your /quicklisp/local-projects/

load cl-talib:
(ql:quickload :cl-talib)
(in-package :cl-talib)

example:
(cl-talib::cl-ta-sma *low*) 