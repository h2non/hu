(ns hu.lib.array)

(defn ^boolean contains-vector?
  "Returns true if vector contains given element"
  [vector element]
  (>= (.index-of vector element) 0))

(defn- ^boolean vector-equal?
  [x y]
  (and
    (vector? x)
    (vector? y)
    (identical? (.-length x) (.-length y))
    (loop [xs x
          ys y
          index 0
          count (.-length x)]
    (if (< index count)
      (if (equivalent? (get xs index) (get ys index))
          (recur xs ys (inc index) count)
          false)
      true))))
