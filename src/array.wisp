(ns hu.lib.array)

(defn ^boolean has-array
  [arr element]
  (>= (.index-of arr element) 0))

(defn ^boolean array-equal?
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
