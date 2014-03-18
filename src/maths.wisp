(ns hu.lib.maths
  (:require [hu.lib.type :refer [array?]]))

(defcurry ^array cross
  "Crosses two vectors"
  [x y]
  (when (array? x)
    (if (? (.-length x) 3)
      [(- (* (aget x 1) (aget y 2)) (* (aget x 2) (aget y 1)))
       (- (* (aget x 2) (aget y 0)) (* (aget x 0) (aget y 2)))
       (- (* (aget x 0) (aget y 1)) (* (aget x 1) (aget y 0)))])))
