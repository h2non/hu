(ns hu.lib.number
  (:require
    [hu.lib.common :refer [number?]]))

(def ^number max (.-max Math))
(def ^number min (.-min Math))
(def ^number abs (.-abs Math))
(def ^number round (.-round Math))
(def ^number floor (.-floor Math))
(def ^number sin (.-sin Math))
(def ^number tan (.-tan Math))
(def ^number cos (.-cos Math))
(def ^number asin (.-asin Math))
(def ^number atan (.-atan Math))
(def ^number atan2 (.-atan2 Math))
(def ^number ceil (.-ceil Math))
(def ^number PI (.-PI Math))
(def ^number exp (.-exp Math))
(def ^number sqrt (.-sqrt Math))

(defn ^boolean odd
  [n] (or
    (> (mod n 2) 0)
    (< (mod n 2) 0)))

(defn ^boolean even
  [n] (identical? (mod n 2) 0))

(defn ^number inc
  [x] (+ x 1))

(defn ^number dec
  [x] (- x 1))

(defn ^number signum
  [x]
  (cond
    (identical? x 0) 0
    (< x 0) -1
    (> x 0) 1))

(defn ^boolean negative?
  [x] (< x 0))

(defn ^number negate
  [x]
  (* (abs x) (if (>= (signum x) 0) -1 1)))

(defn ^number recip
  [x] (/ 1 x))

(defcurry ^number div
  [x y] (floor (/ x y)))

(defn ^number NaN?
  [x]
  (if (identical? x x) false true))

(defn ^number int
  [x]
  (if (>= x 0)
      (.floor Math x)
      (.floor Math x))
    (.char-code-at x 0))

