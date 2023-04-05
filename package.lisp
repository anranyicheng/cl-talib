;;;; package.lisp

(defpackage #:cl-talib
  (:use #:cl #:autowrap)
  (:shadow :remove)
  (:export "cl-ta-cos" 
	   "cl-ta-ht-phasor" 
	   "cl-ta-cdl-hikkake-mod" 
	   "cl-ta-stoch-rsi" 
	   "cl-ta-div" 
	   "cl-ta-acos" 
	   "cl-ta-stochf" 
	   "cl-ta-adxr" 
	   "cl-ta-min-max-index" 
	   "cl-ta-minus-di" 
	   "cl-ta-tema" 
	   "cl-ta-cdl-x-side-gap-3methods" 
	   "cl-ta-cdl-abandoned-baby" 
	   "cl-ta-exp" 
	   "cl-ta-sqrt" 
	   "cl-ta-cdl-3stars-in-south" 
	   "cl-ta-cdl-in-neck" 
	   "cl-ta-mult" 
	   "cl-ta-cdl-evening-star" 
	   "cl-ta-med-price" 
	   "cl-ta-avgprice" 
	   "cl-ta-cdl-breakaway" 
	   "cl-ta-adosc" 
	   "cl-ta-min-max" 
	   "cl-ta-min" 
	   "cl-ta-linear-reg" 
	   "cl-ta-cdl-belt-hold" 
	   "cl-ta-cdl-unique-3river" 
	   "cl-ta-dema" 
	   "cl-ta-cdl-tasuki-gap" 
	   "cl-ta-trima" 
	   "cl-ta-cdl-spinning-top" 
	   "cl-ta-max-index" 
	   "cl-ta-cdl-kicking-by-length" 
	   "cl-ta-cdl-gap-side-side-white" 
	   "cl-ta-sar" 
	   "cl-ta-sarext" 
	   "cl-ta-macd" 
	   "cl-ta-atan" 
	   "cl-ta-tan" 
	   "cl-ta-sma" 
	   "cl-ta-tanh" 
	   "cl-ta-minus-dm" 
	   "cl-ta-ema" 
	   "cl-ta-cdl-counterattack" 
	   "cl-ta-cdl-hanging-man" 
	   "cl-ta-obv" 
	   "cl-ta-typ-price" 
	   "cl-ta-rocr100" 
	   "cl-ta-adx" 
	   "cl-ta-kama" 
	   "cl-ta-cdl-morning-doji-star" 
	   "cl-ta-cdl-2crows" 
	   "cl-ta-cdl-evening-doji-star" 
	   "cl-ta-wclprice" 
	   "cl-ta-cmo" 
	   "cl-ta-plus-di" 
	   "cl-ta-aroon-osc" 
	   "cl-ta-cci" 
	   "cl-ta-cdl-on-neck" 
	   "cl-ta-stddev" 
	   "cl-ta-cdl-marubozu" 
	   "cl-ta-max" 
	   "cl-ta-cdl-homing-pigeon" 
	   "cl-ta-atr" 
	   "cl-ta-cdl-separating-lines" 
	   "cl-ta-natr" 
	   "cl-ta-cdl-doji-star" 
	   "cl-ta-bbands" 
	   "cl-ta-cdl-kicking" 
	   "cl-ta-cdl-doji" 
	   "cl-ta-ceil" 
	   "cl-ta-ppo" 
	   "cl-ta-cdl-takuri" 
	   "cl-ta-cdl-harami" 
	   "cl-ta-ultosc" 
	   "cl-ta-ln" 
	   "cl-ta-cdl-dragon-flay-doji" 
	   "cl-ta-bop" 
	   "cl-ta-rocp" 
	   "cl-ta-aroon" 
	   "cl-ta-cdl-gravestone-doji" 
	   "cl-ta-cdl-upside-gap-2crows" 
	   "cl-ta-ht-dcperiod" 
	   "cl-ta-cdl-3black-crows" 
	   "cl-ta-rsi" 
	   "cl-ta-ht-trend-line" 
	   "cl-ta-cdl-rickshaw-man" 
	   "cl-ta-linear-reg-angle" 
	   "cl-ta-cdl-shooting-star" 
	   "cl-ta-sub" 
	   "cl-ta-cdl-identical-3crows" 
	   "cl-ta-cdl-rise-fall-3methods" 
	   "cl-ta-bbi" 
	   "cl-ta-cdl-inverted-hammer" 
	   "cl-ta-cdl-long-line" 
	   "cl-ta-cdl-piercing" 
	   "cl-ta-dx" 
	   "cl-ta-macdext" 
	   "cl-ta-roc" 
	   "cl-ta-cdl-conceal-baby-swall" 
	   "cl-ta-willr" 
	   "cl-ta-cdl-mat-hold" 
	   "cl-ta-ht-dcphase" 
	   "cl-ta-cdl-closing-marubozu" 
	   "cl-ta-cdl-stalled-pattern" 
	   "cl-ta-tsf" 
	   "cl-ta-apo" 
	   "cl-ta-wma" 
	   "cl-ta-stoch" 
	   "cl-ta-cdl-3line-strike" 
	   "cl-ta-cdl-3inside" 
	   "cl-ta-plus-dm" 
	   "cl-ta-sinh" 
	   "cl-ta-mavp" 
	   "cl-ta-cdl-ladder-bottom" 
	   "cl-ta-cdl-short-line" 
	   "cl-ta-midpoint" 
	   "cl-ta-cdl-tristar" 
	   "cl-ta-linear-reg-slope" 
	   "cl-ta-mid-price" 
	   "cl-ta-correl" 
	   "cl-ta-mfi" 
	   "cl-ta-cosh" 
	   "cl-ta-mom" 
	   "cl-ta-min-index" 
	   "cl-ta-cdl-hikkake" 
	   "cl-ta-mama" 
	   "cl-ta-var" 
	   "cl-ta-cdl-dark-cloud-cover" 
	   "cl-ta-cdl-3white-soldiers" 
	   "cl-ta-cdl-high-wave" 
	   "cl-ta-cdl-morning-star" 
	   "cl-ta-cdl-advance-block" 
	   "cl-ta-macdfix" 
	   "cl-ta-sum" 
	   "cl-ta-ht-sine" 
	   "cl-ta-rocr" 
	   "cl-ta-add" 
	   "cl-ta-beta" 
	   "cl-ta-cdl-engulfing" 
	   "cl-ta-cdl-matching-low" 
	   "cl-ta-linear-reg-intercept" 
	   "cl-ta-cdl-harami-cross" 
	   "cl-ta-cdl-3outside" 
	   "cl-ta-t3" 
	   "cl-ta-cdl-long-legged-doji" 
	   "cl-ta-sin" 
	   "cl-ta-floor" 
	   "cl-ta-asin" 
	   "cl-ta-cdl-hammer" 
	   "cl-ta-cdl-stick-sandwich" 
	   "cl-ta-trange" 
	   "cl-ta-log10" 
	   "cl-ta-ht-trend-mode" 
	   "cl-ta-ad" 
	   "cl-ta-trix" 
	   "cl-ta-cdl-thrusting"))