(ns hu.lib.maths)

(defn ^mixed cross
  "Crosses two vectors"
  [A B]
  (if (array? A B)
    (if (identical? (.-length A) 3)
      [(- (* (aget A 1) (aget B 2)) (* (aget A 2) (aget B 1)))
       (- (* (aget A 2) (aget B 0)) (* (aget A 0) (aget B 2)))
        (- (* (aget A 0) (aget B 1)) (* (aget A 1) (aget B 0)))]
      )))

(def ^array x cross)