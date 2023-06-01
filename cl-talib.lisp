;;;; cl-talib.lisp
(in-package #:cl-talib)

;;---------------------------------------------------------------->>>
#+sbcl
(eval-when (:compile-toplevel :load-toplevel :execute)
  (sb-int:set-floating-point-modes :traps nil))
;; Arithmetic error FLOATING-POINT-INVALID-OPERATION signalled ---<<<

(eval-when (:compile-toplevel :load-toplevel)
  (ensure-directories-exist
   (concatenate 'string (namestring (asdf:system-source-directory :cl-talib)) "specs/")))

(cffi:define-foreign-library talib
  (:unix (:or "libta_lib.so" "libta_lib.so.0"))
  (t (:default "libta_lib")))
(cffi:use-foreign-library talib)
(sb-ext:gc :full t)

(c-include '(cl-talib include "ta_libc.h") :spec-path '(cl-talib specs))
;; init ta-lib
(ta-initialize)

;; SMA
(defun cl-ta-sma(data &key(period 5))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-sma-lookback period)))
    (ta-sma beg-idx end-idx real period out-begidx out-nb-element
	    (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))

(defun cl-ta-ema(data &key(period 5))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-ema-lookback period)))
    (ta-ema beg-idx end-idx real period out-begidx out-nb-element
	    (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


(defun cl-ta-wma(data &key(period 5))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-wma-lookback period)))
    (ta-wma beg-idx end-idx real period out-begidx out-nb-element
	    (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


(defun cl-ta-dema(data &key(period 5))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-dema-lookback period)))
    (ta-dema beg-idx end-idx real period out-begidx out-nb-element
	     (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))

(defun cl-ta-tema(data &key(period 5))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-tema-lookback period)))
    (ta-tema beg-idx end-idx real period out-begidx out-nb-element
	     (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))

(defun cl-ta-trima(data &key(period 5))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-trima-lookback period)))
    (ta-trima beg-idx end-idx real period out-begidx out-nb-element
	      (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))

(defun cl-ta-kama(data &key(period 5))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-kama-lookback period)))
    (ta-kama beg-idx end-idx real period out-begidx out-nb-element
	     (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))

(defun cl-ta-t3(data &key(period 5) (vfactor 0.7d0))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-t3-lookback period (coerce vfactor 'double-float))))
    (ta-t3 beg-idx end-idx real period (coerce vfactor 'double-float)
	   out-begidx out-nb-element (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))

(defun cl-ta-mama(data &key(fastlimit 0.5d0)(slowlimit 0.05d0))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-mama (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(out-fama (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-mama-lookback (coerce fastlimit 'double-float)
				    (coerce slowlimit 'double-float))))
    (ta-mama beg-idx end-idx real  (coerce fastlimit 'double-float)
	     (coerce slowlimit 'double-float) out-begidx out-nb-element
	     (cffi:mem-aptr out-mama :double lookback)
	     (cffi:mem-aptr out-fama :double lookback))
    (multiple-value-list
     (values
      (cffi:foreign-array-to-lisp out-mama (list :array :double size))
      (cffi:foreign-array-to-lisp out-fama (list :array :double size))))))


;; bollinger bands

(defun cl-ta-bbands(data &key(period 5) (nb-devup 2) (nb-devdn 2)
			   (matype +ta-ma-type-sma+))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-up-band (cffi:foreign-alloc
		      :double
		      :initial-contents
		      (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(out-mid-band (cffi:foreign-alloc
		       :double
		       :initial-contents
		       (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(out-dn-band (cffi:foreign-alloc
		      :double
		      :initial-contents
		      (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-bbands-lookback period (coerce nb-devup 'double-float)
				      (coerce nb-devdn 'double-float)
				      matype)))
    (ta-bbands beg-idx end-idx real period
	       (coerce nb-devup 'double-float)
	       (coerce nb-devdn 'double-float)
	       matype out-begidx
	       out-nb-element
	       (cffi:mem-aptr out-up-band :double lookback)
	       (cffi:mem-aptr out-mid-band :double lookback)
	       (cffi:mem-aptr out-dn-band :double lookback))
    (multiple-value-list
     (values
      (cffi:foreign-array-to-lisp out-up-band (list :array :double size))
      (cffi:foreign-array-to-lisp out-mid-band (list :array :double size))
      (cffi:foreign-array-to-lisp out-dn-band (list :array :double size))))))

;; RSI
(defun cl-ta-rsi(data &key(period 14))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-rsi-lookback period)))
    (ta-rsi  beg-idx end-idx real period out-begidx out-nb-element
	     (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;;MACD

(defun cl-ta-macd(data &key(fastperiod 12)(slowperiod 26)(signalperiod 9))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-macd (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(out-macd-hist (cffi:foreign-alloc
			:double
			:initial-contents
			(make-array size :element-type 'double-float :initial-element 0.0d0)))
	(out-signal (cffi:foreign-alloc
		     :double
		     :initial-contents
		     (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-macd-lookback fastperiod slowperiod signalperiod)))
    (ta-macd  beg-idx end-idx real fastperiod slowperiod signalperiod
	      out-begidx out-nb-element
	      (cffi:mem-aptr out-macd :double lookback)
	      (cffi:mem-aptr out-signal :double lookback)
	      (cffi:mem-aptr out-macd-hist :double lookback))
    (multiple-value-list
     (values
      (cffi:foreign-array-to-lisp out-macd (list :array :double size))
      (cffi:foreign-array-to-lisp out-signal (list :array :double size))
      (cffi:foreign-array-to-lisp out-macd-hist (list :array :double size))))))


;; MACDEXT 0.0d0 => NAN
(defun cl-ta-macdext(data &key(fastperiod 12)(fast_matype +ta-ma-type-sma+)
			    (slowperiod 26) (slow_matype +ta-ma-type-sma+)
			    (signalperiod 9) (signal-matype +ta-ma-type-sma+))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-macd (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(out-macd-hist (cffi:foreign-alloc
			:double
			:initial-contents
			(make-array size :element-type 'double-float :initial-element 0.0d0)))
	(out-signal (cffi:foreign-alloc
		     :double
		     :initial-contents
		     (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-macdext-lookback fastperiod  fast_matype
				       slowperiod slow_matype
				       signalperiod signal-matype)))
    (ta-macdext beg-idx end-idx real fastperiod fast_matype
		slowperiod slow_matype
		signalperiod signal-matype 
		out-begidx out-nb-element
		(cffi:mem-aptr out-macd :double lookback)
		(cffi:mem-aptr out-signal :double lookback)
		(cffi:mem-aptr out-macd-hist :double lookback))
    (multiple-value-list
     (values
      (cffi:foreign-array-to-lisp out-macd (list :array :double size))
      (cffi:foreign-array-to-lisp out-signal (list :array :double size))
      (cffi:foreign-array-to-lisp out-macd-hist (list :array :double size))))))

;; KDJ -- STOCH
(defun cl-ta-stoch(high-data low-data close-data
		   &key(fastk_period 5) (slowk_period 3)
		     (slowk_matype +ta-ma-type-sma+ )(slowd_period 3)
		     (slowd_matype +ta-ma-type-sma+))
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-slowk (cffi:foreign-alloc
		    :double
		    :initial-contents
		    (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(out-slowd (cffi:foreign-alloc
		    :double
		    :initial-contents
		    (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-stoch-lookback fastk_period slowk_period slowk_matype
				     slowd_period slowd_matype)))
    (ta-stoch beg-idx end-idx in-high in-low in-close
	      fastk_period slowk_period slowk_matype
	      slowd_period slowd_matype
	      out-begidx out-nb-element
	      (cffi:mem-aptr out-slowk :double lookback)
	      (cffi:mem-aptr out-slowd :double lookback))
    (multiple-value-list
     (values
      (cffi:foreign-array-to-lisp out-slowk (list :array :double size))
      (cffi:foreign-array-to-lisp out-slowd (list :array :double size))))))




(defun cl-ta-stochf(high-data low-data close-data
		    &key(fastk_period 5) (fastd_period 3)
		      (fastd_matype +ta-ma-type-sma+))
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-fastk (cffi:foreign-alloc
		    :double
		    :initial-contents
		    (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(out-fastd (cffi:foreign-alloc
		    :double
		    :initial-contents
		    (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-stochf-lookback fastk_period fastd_period fastd_matype)))
    (ta-stochf beg-idx end-idx in-high in-low in-close
	       fastk_period fastd_period fastd_matype
	       out-begidx out-nb-element
	       (cffi:mem-aptr out-fastk :double lookback)
	       (cffi:mem-aptr out-fastd :double lookback))
    (multiple-value-list
     (values
      (cffi:foreign-array-to-lisp out-fastk (list :array :double size))
      (cffi:foreign-array-to-lisp out-fastd (list :array :double size))))))


(defun cl-ta-stoch-rsi(data &key(period 14) (fastk_period 5) (fastd_period 3)
			      (fastd_matype +ta-ma-type-sma+))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-fastk (cffi:foreign-alloc
		    :double
		    :initial-contents
		    (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(out-fastd (cffi:foreign-alloc
		    :double
		    :initial-contents
		    (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-stochrsi-lookback period fastk_period fastd_period fastd_matype)))
    (ta-stochrsi  beg-idx end-idx real period
		  fastk_period fastd_period fastd_matype 
		  out-begidx out-nb-element
		  (cffi:mem-aptr out-fastk :double lookback)
		  (cffi:mem-aptr out-fastd :double lookback))
    (multiple-value-list
     (values
      (cffi:foreign-array-to-lisp out-fastk (list :array :double size))
      (cffi:foreign-array-to-lisp out-fastd (list :array :double size))))))

;; CCI

(defun cl-ta-cci(high-data low-data close-data &key(period 14))
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-cci-lookback period)))
    (ta-cci  beg-idx end-idx in-high in-low in-close
	     period out-begidx out-nb-element
	     (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))

;; WR: Williams' %R (Momentum Indicators)
(defun cl-ta-willr(high-data low-data close-data &key(period 14))
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-willr-lookback period)))
    (ta-willr beg-idx end-idx in-high in-low in-close
	      period out-begidx out-nb-element
	      (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))

;; bull/bear index   bbi
(defun cl-ta-bbi(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlkickingbylength-lookback)))
    (ta-cdlkickingbylength beg-idx end-idx in-open in-high in-low in-close
			   out-begidx out-nb-element
			   (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; ACOS
(defun cl-ta-acos(data)
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-acos-lookback)))
    (ta-acos beg-idx end-idx real out-begidx out-nb-element
	     (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))

;; ASIN
(defun cl-ta-asin(data)
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-asin-lookback)))
    (ta-asin beg-idx end-idx real out-begidx out-nb-element
	     (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))

;; ATAN
(defun cl-ta-atan(data)
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-atan-lookback)))
    (ta-atan beg-idx end-idx real out-begidx out-nb-element
	     (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))
;; AD

(defun cl-ta-ad(high-data low-data close-data volume-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(in-volume (cffi:foreign-alloc
		    :double
		    :initial-contents
		    (make-array size :element-type 'double-float
				     :initial-contents
				     (mapcar (lambda(x)(coerce x 'double-float)) volume-data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-ad-lookback)))
    (ta-ad beg-idx end-idx in-high in-low in-close in-volume
	   out-begidx out-nb-element
	   (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))

;; ADD
(defun cl-ta-add(data-1 data-2)
  (let*((size (length data-1))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-data-1 (cffi:foreign-alloc
		    :double
		    :initial-contents
		    (make-array size :element-type 'double-float
				     :initial-contents
				     (mapcar (lambda(x)(coerce x 'double-float)) data-a))))
	(in-data-2 (cffi:foreign-alloc
		    :double
		    :initial-contents
		    (make-array size :element-type 'double-float
				     :initial-contents
				     (mapcar (lambda(x)(coerce x 'double-float)) data-2))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-add-lookback)))
    (ta-add beg-idx end-idx in-data-1 in-data-2 
	    out-begidx out-nb-element
	    (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))

;; ADOSC
(defun cl-ta-adosc(high-data low-data close-data volume-data
		   &key(fastperiod 3)(slowperiod 10))
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(in-volume (cffi:foreign-alloc
		    :double
		    :initial-contents
		    (make-array size :element-type 'double-float
				     :initial-contents
				     (mapcar (lambda(x)(coerce x 'double-float)) volume-data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-element 0.0d0)))
	(lookback (ta-adosc-lookback fastperiod slowperiod)))
    (ta-adosc beg-idx end-idx in-high in-low in-close in-volume
	      fastperiod slowperiod
	      out-begidx out-nb-element
	      (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))

;; ADX
(defun cl-ta-adx(high-data low-data close-data &key(period 14))
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-element 0.0d0)))
	(lookback (ta-adx-lookback period)))
    (ta-adx beg-idx end-idx in-high in-low in-close period
	    out-begidx out-nb-element
	    (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;; ADXR

(defun cl-ta-adxr(high-data low-data close-data &key(period 14))
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-adxr-lookback period)))
    (ta-adxr beg-idx end-idx in-high in-low in-close period
	     out-begidx out-nb-element
	     (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;; APO
(defun cl-ta-apo(data &key(fastperiod 12)(slowperiod 26)
			(matype +ta-ma-type-sma+))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-apo-lookback fastperiod slowperiod matype)))
    (ta-apo beg-idx end-idx real fastperiod slowperiod matype
	    out-begidx out-nb-element
	    (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))
;; AROON

(defun cl-ta-aroon(high-data low-data &key(period 14))
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(out-aroon-dn (cffi:foreign-alloc
		       :double
		       :initial-contents
		       (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(out-aroon-up (cffi:foreign-alloc
		       :double
		       :initial-contents
		       (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-aroon-lookback period)))
    (ta-aroon beg-idx end-idx in-high in-low period
	      out-begidx out-nb-element
	      (cffi:mem-aptr out-aroon-dn :double lookback)
	      (cffi:mem-aptr out-aroon-up :double lookback))
    (multiple-value-list
     (values
      (cffi:foreign-array-to-lisp out-aroon-dn (list :array :double size))
      (cffi:foreign-array-to-lisp out-aroon-up (list :array :double size))))))


;; AROONOSC

(defun cl-ta-aroon-osc(high-data low-data &key(period 14))
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))

	(lookback (ta-aroonosc-lookback period)))
    (ta-aroonosc beg-idx end-idx in-high in-low period
		 out-begidx out-nb-element
		 (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;;ATR


(defun cl-ta-atr(high-data low-data close-data &key(period 14))
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-atr-lookback period)))
    (ta-atr beg-idx end-idx in-high in-low in-close period
	    out-begidx out-nb-element
	    (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))

;; AVGPRICE
(defun cl-ta-avgprice(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-avgprice-lookback)))
    (ta-avgprice beg-idx end-idx in-open in-high in-low in-close
		 out-begidx out-nb-element
		 (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;; BETA
(defun cl-ta-beta(data-1 data-2 &key(period 5))
  (let*((size (length data-1))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-data-1 (cffi:foreign-alloc
		    :double
		    :initial-contents
		    (make-array size :element-type 'double-float
				     :initial-contents
				     (mapcar (lambda(x)(coerce x 'double-float)) data-a))))
	(in-data-2 (cffi:foreign-alloc
		    :double
		    :initial-contents
		    (make-array size :element-type 'double-float
				     :initial-contents
				     (mapcar (lambda(x)(coerce x 'double-float)) data-2))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-beta-lookback period)))
    (ta-beta beg-idx end-idx in-data-1 in-data-2 period 
	     out-begidx out-nb-element
	     (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;;BOP

(defun cl-ta-bop(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
    	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-bop-lookback)))
    (ta-bop beg-idx end-idx in-open in-high in-low in-close
	    out-begidx out-nb-element
	    (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))

;; CDL-2CROWS
(defun cl-ta-cdl-2crows(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdl2crows-lookback)))
    (ta-cdl2crows beg-idx end-idx in-open in-high in-low in-close
		  out-begidx out-nb-element
		  (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CDL-3BLACK-CROWS
(defun cl-ta-cdl-3black-crows(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdl3blackcrows-lookback)))
    (ta-cdl3blackcrows beg-idx end-idx in-open in-high in-low in-close
		       out-begidx out-nb-element
		       (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CDL-3INSIDE
(defun cl-ta-cdl-3inside(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
    	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdl3inside-lookback)))
    (ta-cdl3inside beg-idx end-idx in-open in-high in-low in-close
		   out-begidx out-nb-element
		   (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CDL-3LINE-STRIKE
(defun cl-ta-cdl-3line-strike(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdl3linestrike-lookback)))
    (ta-cdl3linestrike beg-idx end-idx in-open in-high in-low in-close
		       out-begidx out-nb-element
		       (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))



;; CDL-3OUTSIDE
(defun cl-ta-cdl-3outside(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdl3outside-lookback)))
    (ta-cdl3outside beg-idx end-idx in-open in-high in-low in-close
		    out-begidx out-nb-element
		    (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CDL-3STARS-IN-SOUTH

(defun cl-ta-cdl-3stars-in-south(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
    	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdl3starsinsouth-lookback)))
    (ta-cdl3starsinsouth beg-idx end-idx in-open in-high in-low in-close
			 out-begidx out-nb-element
			 (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CDL-3WHITE-SOLDIERS
(defun cl-ta-cdl-3white-soldiers(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
    	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdl3whitesoldiers-lookback)))
    (ta-cdl3whitesoldiers beg-idx end-idx in-open in-high in-low in-close
			  out-begidx out-nb-element
			  (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))



;; CDL-ABANDONED-BABY
(defun cl-ta-cdl-abandoned-baby(open-data high-data low-data close-data
				&key(penetration 0.30d0))
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
    	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlabandonedbaby-lookback (coerce penetration 'double-float))))
    (ta-cdlabandonedbaby beg-idx end-idx in-open in-high in-low in-close
			 (coerce penetration 'double-float)
			 out-begidx out-nb-element
			 (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))



;; CDL-ADVANCE-BLOCK
(defun cl-ta-cdl-advance-block(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
    	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdladvanceblock-lookback)))
    (ta-cdladvanceblock beg-idx end-idx in-open in-high in-low in-close
			out-begidx out-nb-element
			(cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CDL-BELT-HOLD
(defun cl-ta-cdl-belt-hold(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlbelthold-lookback)))
    (ta-cdlbelthold beg-idx end-idx in-open in-high in-low in-close
		    out-begidx out-nb-element
		    (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))



;; CDL-BREAKAWAY
(defun cl-ta-cdl-breakaway(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlbreakaway-lookback)))
    (ta-cdlbreakaway beg-idx end-idx in-open in-high in-low in-close
		     out-begidx out-nb-element
		     (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CDL-CLOSING-MARUBOZU
(defun cl-ta-cdl-closing-marubozu(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlclosingmarubozu-lookback)))
    (ta-cdlclosingmarubozu beg-idx end-idx in-open in-high in-low in-close
			   out-begidx out-nb-element
			   (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CDL-CONCEAL-BABY-SWALL  Concealing Baby Swallow 
(defun cl-ta-cdl-conceal-baby-swall(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlconcealbabyswall-lookback)))
    (ta-cdlconcealbabyswall beg-idx end-idx in-open in-high in-low in-close
			    out-begidx out-nb-element
			    (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))



;; CDL-COUNTERATTACK Counterattack
(defun cl-ta-cdl-counterattack(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlcounterattack-lookback)))
    (ta-cdlcounterattack beg-idx end-idx in-open in-high in-low in-close
			 out-begidx out-nb-element
			 (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CDL-DARK-CLOUD-COVER
(defun cl-ta-cdl-dark-cloud-cover(open-data high-data low-data close-data
				  &key(penetration 0.50d0))
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdldarkcloudcover-lookback (coerce penetration 'double-float))))
    (ta-cdldarkcloudcover beg-idx end-idx in-open in-high in-low in-close
			  (coerce penetration 'double-float)
			  out-begidx out-nb-element
			  (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CDL-DOJI
(defun cl-ta-cdl-doji(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdldoji-lookback)))
    (ta-cdldoji beg-idx end-idx in-open in-high in-low in-close
		out-begidx out-nb-element
		(cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CDL-DOJI-STAR
(defun cl-ta-cdl-doji-star(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdldojistar-lookback )))
    (ta-cdldojistar beg-idx end-idx in-open in-high in-low in-close
		    out-begidx out-nb-element
		    (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))




;;CDL-DRAGON-FLY-DOJI
(defun cl-ta-cdl-dragon-flay-doji(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdldragonflydoji-lookback )))
    (ta-cdldragonflydoji beg-idx end-idx in-open in-high in-low in-close
			 out-begidx out-nb-element
			 (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CDL-ENGULFING
(defun cl-ta-cdl-engulfing(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlengulfing-lookback )))
    (ta-cdlengulfing beg-idx end-idx in-open in-high in-low in-close
		     out-begidx out-nb-element
		     (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CDL-EVENING-DOJI-STAR
(defun cl-ta-cdl-evening-doji-star(open-data high-data low-data close-data
				   &key(penetration 0.30d0))
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdleveningdojistar-lookback (coerce penetration 'double-float))))
    (ta-cdleveningdojistar beg-idx end-idx in-open in-high in-low in-close
			   (coerce penetration 'double-float)
			   out-begidx out-nb-element
			   (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))



;; CDL-EVENING-STAR
(defun cl-ta-cdl-evening-star(open-data high-data low-data close-data
			      &key(penetration 0.30d0))
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdleveningstar-lookback (coerce penetration 'double-float))))
    (ta-cdleveningstar beg-idx end-idx in-open in-high in-low in-close
		       (coerce penetration 'double-float)
		       out-begidx out-nb-element
		       (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CDL-GAP-SIDE-SIDE-WHITE
(defun cl-ta-cdl-gap-side-side-white(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlgapsidesidewhite-lookback  )))
    (ta-cdlgapsidesidewhite beg-idx end-idx in-open in-high in-low in-close
			    out-begidx out-nb-element
			    (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CDL-GRAVESTONE-DOJI
(defun cl-ta-cdl-gravestone-doji(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlgravestonedoji-lookback)))
    (ta-cdlgravestonedoji beg-idx end-idx in-open in-high in-low in-close
			  out-begidx out-nb-element
			  (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))

;; CDL-HAMMER
(defun cl-ta-cdl-hammer(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlhammer-lookback)))
    (ta-cdlhammer beg-idx end-idx in-open in-high in-low in-close
		  out-begidx out-nb-element
		  (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))

;; CDL-HANGING-MAN
(defun cl-ta-cdl-hanging-man(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlhangingman-lookback)))
    (ta-cdlhangingman beg-idx end-idx in-open in-high in-low in-close
		      out-begidx out-nb-element
		      (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CDL-HARAMI
(defun cl-ta-cdl-harami(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlharami-lookback)))
    (ta-cdlharami beg-idx end-idx in-open in-high in-low in-close
		  out-begidx out-nb-element
		  (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))



;; CDL-HARAMI-CROSS
(defun cl-ta-cdl-harami-cross(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlharamicross-lookback)))
    (ta-cdlharamicross beg-idx end-idx in-open in-high in-low in-close
		       out-begidx out-nb-element
		       (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CDL-HIGH-WAVE
(defun cl-ta-cdl-high-wave(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlhighwave-lookback)))
    (ta-cdlhighwave beg-idx end-idx in-open in-high in-low in-close
		    out-begidx out-nb-element
		    (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CDL-HIKKAKE
(defun cl-ta-cdl-hikkake(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlhikkake-lookback)))
    (ta-cdlhikkake beg-idx end-idx in-open in-high in-low in-close
		   out-begidx out-nb-element
		   (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CDL-HIKKAKE-MOD
(defun cl-ta-cdl-hikkake-mod(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlhikkakemod-lookback)))
    (ta-cdlhikkakemod beg-idx end-idx in-open in-high in-low in-close
		      out-begidx out-nb-element
		      (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CDL-HOMING-PIGEON
(defun cl-ta-cdl-homing-pigeon(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlhomingpigeon-lookback)))
    (ta-cdlhomingpigeon beg-idx end-idx in-open in-high in-low in-close
			out-begidx out-nb-element
			(cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CDL-IDENTICAL-3CROWS
(defun cl-ta-cdl-identical-3crows(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlidentical3crows-lookback)))
    (ta-cdlidentical3crows beg-idx end-idx in-open in-high in-low in-close
			   out-begidx out-nb-element
			   (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))




;; CDL-IN-NECK
(defun cl-ta-cdl-in-neck(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlinneck-lookback)))
    (ta-cdlinneck beg-idx end-idx in-open in-high in-low in-close
		  out-begidx out-nb-element
		  (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CDL-INVERTED-HAMMER
(defun cl-ta-cdl-inverted-hammer(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlinvertedhammer-lookback)))
    (ta-cdlinvertedhammer beg-idx end-idx in-open in-high in-low in-close
			  out-begidx out-nb-element
			  (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CDL-KICKING
(defun cl-ta-cdl-kicking(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlkicking-lookback)))
    (ta-cdlkicking beg-idx end-idx in-open in-high in-low in-close
		   out-begidx out-nb-element
		   (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CDL-KICKING-BY-LENGTH
(defun cl-ta-cdl-kicking-by-length(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlkickingbylength-lookback)))
    (ta-cdlkickingbylength beg-idx end-idx in-open in-high in-low in-close
			   out-begidx out-nb-element
			   (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))



;; CDL-LADDER-BOTTOM

(defun cl-ta-cdl-ladder-bottom(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlladderbottom-lookback)))
    (ta-cdlladderbottom beg-idx end-idx in-open in-high in-low in-close
			out-begidx out-nb-element
			(cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))



;; CDL-LONG-LEGGED-DOJI
(defun cl-ta-cdl-long-legged-doji(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdllongleggeddoji-lookback)))
    (ta-cdllongleggeddoji beg-idx end-idx in-open in-high in-low in-close
			  out-begidx out-nb-element
			  (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))



;; CDL-LONG-LINE
(defun cl-ta-cdl-long-line(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdllongline-lookback)))
    (ta-cdllongline beg-idx end-idx in-open in-high in-low in-close
		    out-begidx out-nb-element
		    (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CDL-MARUBOZU
(defun cl-ta-cdl-marubozu(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlmarubozu-lookback)))
    (ta-cdlmarubozu beg-idx end-idx in-open in-high in-low in-close
		    out-begidx out-nb-element
		    (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CDL-MATCHING-LOW
(defun cl-ta-cdl-matching-low(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlmatchinglow-lookback)))
    (ta-cdlmatchinglow beg-idx end-idx in-open in-high in-low in-close
		       out-begidx out-nb-element
		       (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CDL-MAT-HOLD
(defun cl-ta-cdl-mat-hold(open-data high-data low-data close-data
			  &key(penetration 0.30d0))
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlmathold-lookback (coerce penetration 'double-float))))
    (ta-cdlmathold beg-idx end-idx in-open in-high in-low in-close
		   (coerce penetration 'double-float)
		   out-begidx out-nb-element
		   (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))



;; CDL-MORNING-DOJI-STAR
(defun cl-ta-cdl-morning-doji-star(open-data high-data low-data close-data
				   &key(penetration 0.30d0))
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlmorningdojistar-lookback
		   (coerce penetration 'double-float))))
    (ta-cdlmorningdojistar beg-idx end-idx in-open in-high in-low in-close
			   (coerce penetration 'double-float)
			   out-begidx out-nb-element
			   (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CDL-MORNING-STAR
(defun cl-ta-cdl-morning-star(open-data high-data low-data close-data
			      &key(penetration 0.30d0))
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlmorningstar-lookback
		   (coerce penetration 'double-float))))
    (ta-cdlmorningstar beg-idx end-idx in-open in-high in-low in-close
		       (coerce penetration 'double-float)
		       out-begidx out-nb-element
		       (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))



;; CDL-ON-NECK
(defun cl-ta-cdl-on-neck(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlonneck-lookback)))
    (ta-cdlonneck beg-idx end-idx in-open in-high in-low in-close
		  out-begidx out-nb-element
		  (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CDL-PIERCING
(defun cl-ta-cdl-piercing(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlpiercing-lookback)))
    (ta-cdlpiercing beg-idx end-idx in-open in-high in-low in-close
		    out-begidx out-nb-element
		    (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CDL-RICKSHAW-MAN
(defun cl-ta-cdl-rickshaw-man(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlrickshawman-lookback)))
    (ta-cdlrickshawman beg-idx end-idx in-open in-high in-low in-close
		       out-begidx out-nb-element
		       (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CDL-RISE-FALL-3METHODS
(defun cl-ta-cdl-rise-fall-3methods(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlrisefall3methods-lookback)))
    (ta-cdlrisefall3methods beg-idx end-idx in-open in-high in-low in-close
			    out-begidx out-nb-element
			    (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CDL-SEPARATING-LINES
(defun cl-ta-cdl-separating-lines(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlseparatinglines-lookback)))
    (ta-cdlseparatinglines beg-idx end-idx in-open in-high in-low in-close
			   out-begidx out-nb-element
			   (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CDL-SHOOTING-STAR
(defun cl-ta-cdl-shooting-star(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlshootingstar-lookback)))
    (ta-cdlshootingstar beg-idx end-idx in-open in-high in-low in-close
			out-begidx out-nb-element
			(cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CDL-SHORT-LINE
(defun cl-ta-cdl-short-line(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlshortline-lookback)))
    (ta-cdlshortline beg-idx end-idx in-open in-high in-low in-close
		     out-begidx out-nb-element
		     (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CDL-SPINNING-TOP
(defun cl-ta-cdl-spinning-top(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlspinningtop-lookback)))
    (ta-cdlspinningtop beg-idx end-idx in-open in-high in-low in-close
		       out-begidx out-nb-element
		       (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CDL-STALLED-PATTERN
(defun cl-ta-cdl-stalled-pattern(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlstalledpattern-lookback)))
    (ta-cdlstalledpattern beg-idx end-idx in-open in-high in-low in-close
			  out-begidx out-nb-element
			  (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CDL-STICK-SANDWICH
(defun cl-ta-cdl-stick-sandwich(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlsticksandwich-lookback)))
    (ta-cdlsticksandwich beg-idx end-idx in-open in-high in-low in-close
			 out-begidx out-nb-element
			 (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))



;; CDL-TAKURI
(defun cl-ta-cdl-takuri(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdltakuri-lookback)))
    (ta-cdltakuri beg-idx end-idx in-open in-high in-low in-close
		  out-begidx out-nb-element
		  (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))



;; CDL-TASUKI-GAP
(defun cl-ta-cdl-tasuki-gap(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdltasukigap-lookback)))
    (ta-cdltasukigap beg-idx end-idx in-open in-high in-low in-close
		     out-begidx out-nb-element
		     (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CDL-THRUSTING
(defun cl-ta-cdl-thrusting(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlthrusting-lookback)))
    (ta-cdlthrusting beg-idx end-idx in-open in-high in-low in-close
		     out-begidx out-nb-element
		     (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CDL-TRISTAR
(defun cl-ta-cdl-tristar(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdltristar-lookback)))
    (ta-cdltristar beg-idx end-idx in-open in-high in-low in-close
		   out-begidx out-nb-element
		   (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))

;; CDL-UNIQUE-3RIVER
(defun cl-ta-cdl-unique-3river(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlunique3river-lookback)))
    (ta-cdlunique3river beg-idx end-idx in-open in-high in-low in-close
			out-begidx out-nb-element
			(cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))

;; CDL-UPSIDE-GAP-2CROWS
(defun cl-ta-cdl-upside-gap-2crows(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlupsidegap2crows-lookback)))
    (ta-cdlupsidegap2crows beg-idx end-idx in-open in-high in-low in-close
			   out-begidx out-nb-element
			   (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))

;; CDL-X-SIDE-GAP-3METHODS
(defun cl-ta-cdl-x-side-gap-3methods(open-data high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-open (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) open-data))))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-cdlxsidegap3methods-lookback)))
    (ta-cdlxsidegap3methods beg-idx end-idx in-open in-high in-low in-close
			    out-begidx out-nb-element
			    (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; CEIL
(defun cl-ta-ceil(data)
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-ceil-lookback)))
    (ta-ceil beg-idx end-idx real out-begidx out-nb-element
	     (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;; CMO
(defun cl-ta-cmo(data &key(period 14))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-cmo-lookback period)))
    (ta-cmo beg-idx end-idx real period out-begidx out-nb-element
	    (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;; CORREL, 0.0d0 => NAN
(defun cl-ta-correl(data-1 data-2 &key(period 30))
  (let*((size (length data-1))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-data-1 (cffi:foreign-alloc
		    :double
		    :initial-contents
		    (make-array size :element-type 'double-float
				     :initial-contents
				     (mapcar (lambda(x)(coerce x 'double-float)) data-a))))
	(in-data-2 (cffi:foreign-alloc
		    :double
		    :initial-contents
		    (make-array size :element-type 'double-float
				     :initial-contents
				     (mapcar (lambda(x)(coerce x 'double-float)) data-2))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-correl-lookback period)))
    (ta-correl beg-idx end-idx in-data-1 in-data-2 period 
	       out-begidx out-nb-element
	       (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))

;; COS
(defun cl-ta-cos(data)
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-cos-lookback)))
    (ta-cos beg-idx end-idx real out-begidx out-nb-element
	    (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))

;; COSH math
(defun cl-ta-cosh(data)
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-cosh-lookback)))
    (ta-cosh beg-idx end-idx real out-begidx out-nb-element
	     (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))

;; DIV math
(defun cl-ta-div(data-1 data-2)
  (let*((size (length data-1))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-data-1 (cffi:foreign-alloc
		    :double
		    :initial-contents
		    (make-array size :element-type 'double-float
				     :initial-contents
				     (mapcar (lambda(x)(coerce x 'double-float)) data-a))))
	(in-data-2 (cffi:foreign-alloc
		    :double
		    :initial-contents
		    (make-array size :element-type 'double-float
				     :initial-contents
				     (mapcar (lambda(x)(coerce x 'double-float)) data-2))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-div-lookback)))
    (ta-div beg-idx end-idx in-data-1 in-data-2 
	    out-begidx out-nb-element
	    (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;; DX
(defun cl-ta-dx(high-data low-data close-data &key(period 14))
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-dx-lookback period)))
    (ta-dx beg-idx end-idx in-high in-low in-close
	   period out-begidx out-nb-element
	   (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;; EXP math
(defun cl-ta-exp(data)
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-exp-lookback)))
    (ta-exp beg-idx end-idx real out-begidx out-nb-element
	    (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))

;; FLOOR math
(defun cl-ta-floor(data)
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-floor-lookback)))
    (ta-floor beg-idx end-idx real out-begidx out-nb-element
	      (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))

;; HT_DCPERIOD   0.0d0=>NAN
(defun cl-ta-ht-dcperiod(data)
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-ht-dcperiod-lookback )))
    (ta-ht-dcperiod beg-idx end-idx real out-begidx out-nb-element
		    (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;; HT_DCPHASE  0.0d0=>NAN
(defun cl-ta-ht-dcphase(data)
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-ht-dcphase-lookback )))
    (ta-ht-dcphase beg-idx end-idx real out-begidx out-nb-element
		   (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;; HT_PHASOR   0.0d0=>NAN
(defun cl-ta-ht-phasor(data)
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-inphase (cffi:foreign-alloc
		      :double
		      :initial-contents
		      (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(out-quadrature (cffi:foreign-alloc
			 :double
			 :initial-contents
			 (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-ht-phasor-lookback )))
    (ta-ht-phasor beg-idx end-idx real out-begidx out-nb-element
		  (cffi:mem-aptr out-inphase :double lookback)
		  (cffi:mem-aptr out-quadrature :double lookback))
    (multiple-value-list
     (values 
      (cffi:foreign-array-to-lisp out-inphase (list :array :double size))
      (cffi:foreign-array-to-lisp out-quadrature (list :array :double size))))))


;; HT_SINE 0.0d0=>NAN
(defun cl-ta-ht-sine(data)
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-inphase (cffi:foreign-alloc
		      :double
		      :initial-contents
		      (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(out-quadrature (cffi:foreign-alloc
			 :double
			 :initial-contents
			 (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-ht-sine-lookback )))
    (ta-ht-sine beg-idx end-idx real out-begidx out-nb-element
		(cffi:mem-aptr out-inphase :double lookback)
		(cffi:mem-aptr out-quadrature :double lookback))
    (multiple-value-list
     (values 
      (cffi:foreign-array-to-lisp out-inphase (list :array :double size))
      (cffi:foreign-array-to-lisp out-quadrature (list :array :double size))))))


;; HT_TREND-LINE  0.0d0=>NAN
(defun cl-ta-ht-trend-line(data)
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-ht-trendline-lookback )))
    (ta-ht-trendline beg-idx end-idx real out-begidx out-nb-element
		     (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))

;; HT_TREND-MODE
(defun cl-ta-ht-trend-mode(data)
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-real (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-ht-trendmode-lookback )))
    (ta-ht-trendmode beg-idx end-idx in-real
		     out-begidx out-nb-element
		     (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))



;; LINEAR-REG    0.0d0=>NAN
(defun cl-ta-linear-reg(data &key(period 14))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-linearreg-lookback period)))
    (ta-linearreg beg-idx end-idx real period out-begidx out-nb-element
		  (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))

;; LINEAR-REG_ANGLE   0.0d0=>NAN
(defun cl-ta-linear-reg-angle(data &key(period 14))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-linearreg-angle-lookback period)))
    (ta-linearreg-angle beg-idx end-idx real period out-begidx out-nb-element
			(cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))

;; LINEAR-REG_INTERCEPT   0.0d0=>NAN
(defun cl-ta-linear-reg-intercept(data &key(period 14))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-linearreg-intercept-lookback period)))
    (ta-linearreg-intercept beg-idx end-idx real period out-begidx out-nb-element
			    (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;; LINEARREG_SLOPE 0.0d0 => NAN
(defun cl-ta-linear-reg-slope(data &key(period 14))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-linearreg-slope-lookback period)))
    (ta-linearreg-slope beg-idx end-idx real period out-begidx out-nb-element
			(cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;; LN log math
(defun cl-ta-ln(data)
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-ln-lookback)))
    (ta-ln beg-idx end-idx real out-begidx out-nb-element
	   (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;; LOG10 log 10 math
(defun cl-ta-log10(data)
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-log10-lookback)))
    (ta-log10 beg-idx end-idx real out-begidx out-nb-element
	      (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;; MACDFIX  0.0d0 =>NAN
(defun cl-ta-macdfix(data &key(signalperiod 9))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-macd (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(out-macd-hist (cffi:foreign-alloc
			:double
			:initial-contents
			(make-array size :element-type 'double-float :initial-element 0.0d0)))
	(out-signal (cffi:foreign-alloc
		     :double
		     :initial-contents
		     (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-macdfix-lookback signalperiod)))
    
    (ta-macdfix beg-idx end-idx real signalperiod
		out-begidx out-nb-element
		(cffi:mem-aptr out-macd :double lookback)
		(cffi:mem-aptr out-signal :double lookback)
		(cffi:mem-aptr out-macd-hist :double lookback))

    (multiple-value-list
     (values
      (cffi:foreign-array-to-lisp out-macd (list :array :double size))
      (cffi:foreign-array-to-lisp out-signal (list :array :double size))
      (cffi:foreign-array-to-lisp out-macd-hist (list :array :double size))))))



;; MAVP  0.0d0 =>NAN

(defun cl-ta-mavp(data periods-data &key(minperiod 14) (maxperiod 30)
				      (matype +ta-ma-type-sma+))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-data (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) data))))
	(in-periods (cffi:foreign-alloc
		     :double
		     :initial-contents
		     (make-array size :element-type 'double-float
				      :initial-contents
				      (mapcar (lambda(x)(coerce x 'double-float)) periods-data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-mavp-lookback minperiod maxperiod matype)))
    (ta-mavp beg-idx end-idx in-data in-periods
	     minperiod maxperiod matype
	     out-begidx out-nb-element
	     (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;; MAX  math  0.0d0 =>NAN
(defun cl-ta-max(data &key(period 30))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-max-lookback  period)))
    (ta-max beg-idx end-idx real period out-begidx out-nb-element
	    (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;; MAX-INDEX

(defun cl-ta-max-index(data &key(period 30))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-real (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-maxindex-lookback period)))
    (ta-maxindex beg-idx end-idx in-real period 
		 out-begidx out-nb-element
		 (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;;  MED-PRICE  Median Price
(defun cl-ta-med-price(high-data low-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-medprice-lookback)))
    (ta-medprice beg-idx end-idx in-high in-low 
		 out-begidx out-nb-element
		 (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;;MFI
(defun cl-ta-mfi(high-data low-data close-data volume-data &key(period 14))
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(in-volume (cffi:foreign-alloc
		    :double
		    :initial-contents
		    (make-array size :element-type 'double-float
				     :initial-contents
				     (mapcar (lambda(x)(coerce x 'double-float)) volume-data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-mfi-lookback period)))
    (ta-mfi beg-idx end-idx in-high in-low in-close in-volume
	    period out-begidx out-nb-element
	    (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))



;; MIDPOINT
(defun cl-ta-midpoint(data &key(period 14))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-real (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-midpoint-lookback  period)))
    (ta-midpoint beg-idx end-idx in-real period 
		 out-begidx out-nb-element
		 (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;; MID-PRICE   0.0d0 =>NAN
(defun cl-ta-mid-price(high-data low-data &key(period 14))
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-midprice-lookback period)))
    (ta-midprice beg-idx end-idx in-high in-low period 
		 out-begidx out-nb-element
		 (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;; MIN  math  0.0d0 =>NAN
(defun cl-ta-min(data &key(period 30))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-min-lookback  period)))
    (ta-min beg-idx end-idx real period out-begidx out-nb-element
	    (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))



;; MIN-INDEX

(defun cl-ta-min-index(data &key(period 30))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-real (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-integer (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-minindex-lookback period)))
    (ta-minindex beg-idx end-idx in-real period 
		 out-begidx out-nb-element
		 (cffi:mem-aptr out-integer :int lookback))
    (cffi:foreign-array-to-lisp out-integer (list :array :int size))))


;; MIN MAX
(defun cl-ta-min-max(data &key(period 30))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-min (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(out-max (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-minmax-lookback  period)))
    (ta-minmax beg-idx end-idx real period out-begidx out-nb-element
	       (cffi:mem-aptr out-min :double lookback)
	       (cffi:mem-aptr out-max :double lookback))
    (multiple-value-list
     (values 
      (cffi:foreign-array-to-lisp out-min (list :array :double size))
      (cffi:foreign-array-to-lisp out-max (list :array :double size))))))


;; MIN MAX INDEX
(defun cl-ta-min-max-index(data &key(period 30))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-real (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-min-idx (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(out-max-idx (cffi:foreign-alloc
		      :int
		      :initial-contents
		      (make-array size :element-type '(signed-byte 32) :initial-element 0)))
	(lookback (ta-minmaxindex-lookback period)))
    (ta-minmaxindex beg-idx end-idx in-real period 
		    out-begidx out-nb-element
		    (cffi:mem-aptr out-min-idx :int lookback)
		    (cffi:mem-aptr out-max-idx :int lookback))
    (multiple-value-list
     (values 
      (cffi:foreign-array-to-lisp out-min-idx (list :array :int size))
      (cffi:foreign-array-to-lisp out-max-idx (list :array :int size))))))


;; MINUS_DI  0.0d0 => NAN
(defun cl-ta-minus-di(high-data low-data close-data &key(period 14))
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-minus-di-lookback period)))
    (ta-minus-di beg-idx end-idx in-high in-low in-close period
		 out-begidx out-nb-element
		 (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;; MINUS_DM 0.0d0 => NAN
(defun cl-ta-minus-dm(high-data low-data &key(period 14))
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-minus-dm-lookback period)))
    (ta-minus-dm beg-idx end-idx in-high in-low period
		 out-begidx out-nb-element
		 (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;; MOM  0.0d0 => NAN
(defun cl-ta-mom(data &key(period 10))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-mom-lookback  period)))
    (ta-mom beg-idx end-idx real period out-begidx out-nb-element
	    (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;; MULT math
(defun cl-ta-mult(data-1 data-2)
  (let*((size (length data-1))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-data-1 (cffi:foreign-alloc
		    :double
		    :initial-contents
		    (make-array size :element-type 'double-float
				     :initial-contents
				     (mapcar (lambda(x)(coerce x 'double-float)) data-a))))
	(in-data-2 (cffi:foreign-alloc
		    :double
		    :initial-contents
		    (make-array size :element-type 'double-float
				     :initial-contents
				     (mapcar (lambda(x)(coerce x 'double-float)) data-2))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-mult-lookback)))
    (ta-mult beg-idx end-idx in-data-1 in-data-2 
	     out-begidx out-nb-element
	     (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;; NATR   0.0d0 => NAN
(defun cl-ta-natr(high-data low-data close-data &key(period 14))
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-natr-lookback period)))
    (ta-natr beg-idx end-idx in-high in-low in-close period
	     out-begidx out-nb-element
	     (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;; OBV 
(defun cl-ta-obv(data volume-data)
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-data (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) data))))
	(in-volume (cffi:foreign-alloc
		    :double
		    :initial-contents
		    (make-array size :element-type 'double-float
				     :initial-contents
				     (mapcar (lambda(x)(coerce x 'double-float)) volume-data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-obv-lookback)))
    (ta-obv beg-idx end-idx in-data in-volume
	    out-begidx out-nb-element
	    (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;; PLUS_DI    0.0d0 => NAN
(defun cl-ta-plus-di(high-data low-data close-data &key(period 14))
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-plus-di-lookback period)))
    (ta-plus-di beg-idx end-idx in-high in-low in-close period
		out-begidx out-nb-element
		(cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))

;; PLUS_DM
(defun cl-ta-plus-dm(high-data low-data &key(period 14))
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-plus-dm-lookback period)))
    (ta-plus-dm beg-idx end-idx in-high in-low period
		out-begidx out-nb-element
		(cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;; PPO  0.0d0 =>NAN
(defun cl-ta-ppo(data &key(fastperiod 12)(slowperiod 26)(matype +ta-ma-type-sma+))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-real (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-ppo-lookback fastperiod slowperiod matype)))
    (ta-ppo beg-idx end-idx in-real 
	    fastperiod slowperiod matype
	    out-begidx out-nb-element
	    (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))



;; ROC  0.0d0 =>NAN
(defun cl-ta-roc(data &key(period 10))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-roc-lookback  period)))
    (ta-roc beg-idx end-idx real period out-begidx out-nb-element
	    (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;; ROCP  0.0d0 =>NAN
(defun cl-ta-rocp(data &key(period 10))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-rocp-lookback  period)))
    (ta-rocp beg-idx end-idx real period out-begidx out-nb-element
	     (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))



;; ROCR  0.0d0 =>NAN
(defun cl-ta-rocr(data &key(period 10))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-rocr-lookback  period)))
    (ta-rocr beg-idx end-idx real period out-begidx out-nb-element
	     (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;; ROCR100  0.0d0 =>NAN
(defun cl-ta-rocr100(data &key(period 10))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-rocr100-lookback  period)))
    (ta-rocr100 beg-idx end-idx real period out-begidx out-nb-element
		(cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;;SAR 0.0d0 =>NAN
(defun cl-ta-sar(high-data low-data &key(acceleration 0.020d0)(maximun 0.20d0))
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-sar-lookback (coerce acceleration 'double-float)
				   (coerce maximun 'double-float))))
    (ta-sar beg-idx end-idx in-high in-low
	    (coerce acceleration 'double-float)
	    (coerce maximun 'double-float)
	    out-begidx out-nb-element
	    (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;;SAREXT 0.0d0 =>NAN
(defun cl-ta-sarext(high-data low-data
		    &key(startvalue 0.0d0)
		      (offsetonreverse 0.0d0)
		      (accelerationinitlong 0.020d0)
		      (accelerationlong 0.020d0)
		      (accelerationmaxlong 0.20d0)
		      (accelerationinitshort 0.020d0)
		      (accelerationshort 0.020d0)
		      (accelerationmaxshort 0.20d0))
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-sarext-lookback
		   (coerce startvalue 'double-float)
		   (coerce offsetonreverse 'double-float)
		   (coerce accelerationinitlong 'double-float)
		   (coerce accelerationlong 'double-float)
		   (coerce accelerationmaxlong 'double-float)
		   (coerce accelerationinitshort 'double-float)
		   (coerce accelerationshort 'double-float)
		   (coerce accelerationmaxshort 'double-float))))
    (ta-sarext  beg-idx end-idx in-high in-low
		(coerce startvalue 'double-float)
		(coerce offsetonreverse 'double-float)
		(coerce accelerationinitlong 'double-float)
		(coerce accelerationlong 'double-float)
		(coerce accelerationmaxlong 'double-float)
		(coerce accelerationinitshort 'double-float)
		(coerce accelerationshort 'double-float)
		(coerce accelerationmaxshort 'double-float)		    
		out-begidx out-nb-element
		(cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;; SIN math
(defun cl-ta-sin(data)
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-sin-lookback)))
    (ta-sin beg-idx end-idx real out-begidx out-nb-element
	    (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;; SINH math
(defun cl-ta-sinh(data)
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-sinh-lookback)))
    (ta-sinh beg-idx end-idx real out-begidx out-nb-element
	     (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))

;; SQRT math
(defun cl-ta-sqrt(data)
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-sqrt-lookback)))
    (ta-sqrt beg-idx end-idx real out-begidx out-nb-element
	     (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;; STDDEV
(defun cl-ta-stddev(data &key(period 10)(nbdev 1.0d0))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-stddev-lookback period (coerce nbdev 'double-float))))
    (ta-stddev beg-idx end-idx real
	       period  (coerce nbdev 'double-float)
	       out-begidx out-nb-element
	       (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))

;; SUB math
(defun cl-ta-sub(data-1 data-2)
  (let*((size (length data-1))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-data-1 (cffi:foreign-alloc
		    :double
		    :initial-contents
		    (make-array size :element-type 'double-float
				     :initial-contents
				     (mapcar (lambda(x)(coerce x 'double-float)) data-a))))
	(in-data-2 (cffi:foreign-alloc
		    :double
		    :initial-contents
		    (make-array size :element-type 'double-float
				     :initial-contents
				     (mapcar (lambda(x)(coerce x 'double-float)) data-2))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-sub-lookback )))
    (ta-sub beg-idx end-idx in-data-1 in-data-2 
	    out-begidx out-nb-element
	    (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;; SUM math
(defun cl-ta-sum(data &key(period 30))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-sum-lookback period)))
    (ta-sum beg-idx end-idx real period 
	    out-begidx out-nb-element
	    (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;; TAN math
(defun cl-ta-tan(data)
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-tan-lookback)))
    (ta-tan beg-idx end-idx real out-begidx out-nb-element
	    (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;; TANH math
(defun cl-ta-tanh(data)
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-tanh-lookback)))
    (ta-tanh beg-idx end-idx real out-begidx out-nb-element
	     (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;; T-RANGE 0.0d0 => NAN
(defun cl-ta-trange(high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-trange-lookback)))
    (ta-trange beg-idx end-idx in-high in-low in-close
	       out-begidx out-nb-element
	       (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;; TRIX  0.0d0 => NAN
(defun cl-ta-trix(data &key(period 30))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-trix-lookback period)))
    (ta-trix beg-idx end-idx real period out-begidx out-nb-element
	     (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;; TSF
(defun cl-ta-tsf(data &key(period 14))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-tsf-lookback period)))
    (ta-tsf beg-idx end-idx real period out-begidx out-nb-element
	    (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;; TYP-PRICE
(defun cl-ta-typ-price(high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-typprice-lookback)))
    (ta-typprice beg-idx end-idx in-high in-low in-close
		 out-begidx out-nb-element
		 (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;;  ULTOSC 0.0d0 => NAN
(defun cl-ta-ultosc(high-data low-data close-data
		    &key(period-1 7)(period-2 14)(period-3 28))
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-ultosc-lookback period-1 period-2 period-3)))
    (ta-ultosc beg-idx end-idx in-high in-low in-close
	       period-1 period-2 period-3
	       out-begidx out-nb-element
	       (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;; VAR 0.0d0 => NAN
(defun cl-ta-var(data &key(period 5)(nbdev 1.0d0))
  (let*((size (length data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(real (cffi:foreign-alloc
	       :double
	       :initial-contents
	       (make-array size :element-type 'double-float
				:initial-contents
				(mapcar (lambda(x)(coerce x 'double-float)) data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-var-lookback period (coerce nbdev 'double-float))))
    (ta-var beg-idx end-idx real
	    period  (coerce nbdev 'double-float)
	    out-begidx out-nb-element
	    (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))


;; W-CL-PRICE Weighted Close Price (Price Transform)
(defun cl-ta-wclprice(high-data low-data close-data)
  (let*((size (length high-data))
	(beg-idx 0)
	(end-idx (- size beg-idx 1))
	(out-begidx (cffi:foreign-alloc
		     :int :initial-element 0))
	(out-nb-element (cffi:foreign-alloc
			 :int :initial-element 0))
	(in-high (cffi:foreign-alloc
		  :double
		  :initial-contents
		  (make-array size :element-type 'double-float
				   :initial-contents
				   (mapcar (lambda(x)(coerce x 'double-float)) high-data))))
	(in-low (cffi:foreign-alloc
		 :double
		 :initial-contents
		 (make-array size :element-type 'double-float
				  :initial-contents
				  (mapcar (lambda(x)(coerce x 'double-float)) low-data))))
	(in-close (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float
				    :initial-contents
				    (mapcar (lambda(x)(coerce x 'double-float)) close-data))))
	(out-real (cffi:foreign-alloc
		   :double
		   :initial-contents
		   (make-array size :element-type 'double-float :initial-element 0.0d0)))
	(lookback (ta-wclprice-lookback)))
    (ta-wclprice beg-idx end-idx in-high in-low in-close
		 out-begidx out-nb-element
		 (cffi:mem-aptr out-real :double lookback))
    (cffi:foreign-array-to-lisp out-real (list :array :double size))))
