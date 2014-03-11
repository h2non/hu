(ns hu.lib.number)

(def max Math.max)
(def min Math.min)

(defn ^boolean odd?
  [n] (identical? (mod n 2) 1))

(defn ^boolean even?
  [n] (identical? (mod n 2) 0))
