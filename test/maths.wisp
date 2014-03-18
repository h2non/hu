(ns hu.test.maths
  (:require
    [assert :refer [equal deep-equal]]
    [hu.lib.maths :as _]))

(suite :cross
  (fn []
    (test :basic
      (fn []
        (deep-equal (.cross _ [3 4 5] [9 -3 0]) [15 45 -45])
        (deep-equal (.cross _ [22 3 4] [-2 3 4]) [0 -96 72])
        (deep-equal (.cross _ [2 3 4] [2 3 4]) [0 0 0])))))
