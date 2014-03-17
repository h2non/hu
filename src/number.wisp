(ns hu.lib.number
  (:require
    [hu.lib.type :refer [number?]]))

(def ^number max (.-max Math))
(def ^number min (.-min Math))
(def ^number abs (.-abs Math))
(def ^number round (.-round Math))
(def ^number random (.-random Math))
(def ^number floor (.-floor Math))
(def ^number sin (.-sin Math))
(def ^number tan (.-tan Math))
(def ^number cos (.-cos Math))
(def ^number asin (.-asin Math))
(def ^number atan (.-atan Math))
(def ^number atan2 (.-atan2 Math))
(def ^number ceil (.-ceil Math))
(def ^number exp (.-exp Math))
(def ^number sqrt (.-sqrt Math))
(def ^number PI (.-PI Math))

(defn ^boolean odd
  "Returns true if the given number is odd"
  [n] (or
    (> (mod n 2) 0)
    (< (mod n 2) 0)))

(defn ^boolean even
  "Returns true if the given number is even"
  [n] (identical? (mod n 2) 0))

(defn ^number inc
  "Increment the given value"
  [x] (+ x 1))

(defn ^number dec
  "Decrement the given value"
  [x] (- x 1))

(defn ^number signum
  "Takes a number and returns either -1, 0,
  or 1 depending on the sign of the number"
  [x]
  (cond
    (identical? x 0) 0
    (< x 0) -1
    (> x 0) 1))

(defn ^boolean negative?
  "Returns true if the given number is negative"
  [x] (< x 0))

(defn ^number negate
  "The negation of the given number"
  [x]
  (* (abs x) (if (>= (signum x) 0) -1 1)))

(defn ^number recip
  "One over the number: ie 1 / x"
  [x] (/ 1 x))

(defcurry ^number div
  "Division truncated down toward negative infinity"
  [x y] (floor (/ x y)))
