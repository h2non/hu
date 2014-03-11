(ns hu.lib.number)

(defn ^boolean odd?
  [n] (identical? (mod n 2) 1))

(defn ^boolean even?
  [n] (identical? (mod n 2) 0))
