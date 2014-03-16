(ns hu.test.array
  (:require
    [assert :refer [equal deep-equal]]
    [hu.lib.array :as _]))

(suite :inArray
  (fn []
    (test :basic
      (fn []
        (equal (.in-array _ [1] 1) true)
        (equal (.in-array _ [:a] :a) true)
        (equal (.in-array _ [true] false) false)
        (equal (.in-array _ [{:a 1}] {:a 1}) false)))))
