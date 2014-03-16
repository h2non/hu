(ns hu.lib.array)

(defn ^boolean in-array
  [arr element]
  (>= (.index-of arr element) 0))

(defn concat
  "Returns list representing the concatenation of the elements in the
  supplied lists."
  [& sequences]
  (reverse
    (reduce
      (fn [result sequence]
        (reduce
          (fn [result item] (cons item result))
          result
          (seq sequence)))
      '()
      sequences)))
