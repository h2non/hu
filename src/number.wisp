(ns hu.lib.number
  (:require
    [hu.lib.common :refer [number?]]))

(def ^number max Math.max)
(def ^number min Math.min)

(defn ^boolean odd?
  [n] (identical? (mod n 2) 1))

(defn ^boolean even?
  [n] (identical? (mod n 2) 0))

(defn ^number inc
  [x] (+ x 1))

(defn ^number dec
  [x] (- x 1))

(defn ^number int
  [x]
  (if (number? x)
    (if (>= x 0)
      (.floor Math x)
      (.floor Math x))
    (.char-code-at x 0)))
