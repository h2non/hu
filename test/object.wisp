(ns hu.test.object
  (:require
    [assert :refer [equal deep-equal]]
    [hu.lib.object :as _]))

(suite :has
  (fn []
    (test :valid
      (fn []
        (equal (.has _ {:a true} :a) true)
        (equal (.has _ {:a false} :b) false)))))

(suite :extend
  (fn []
    (test :basic
      (fn []
        (deep-equal
          (.extend _ {:a true} {:b false}) {:a true, :b false})
        (deep-equal
          (.extend _ {:a true} {:b false }) {:a true, :b false})))
    (test :multiple
      (fn []
        (deep-equal
          (.extend _ {:a 1} {:b 2} {:c 3}) {:a 1, :b 2, :c 3})
        (deep-equal
          (.extend _ {:a 1} {:b 2} {:c 3}) {:a 1, :b 2, :c 3})))))

(suite :each
  (fn []
    (test :object
      (fn []
        (def called false)
        (.each _ {:a true} (fn [] (set! called true)))
        (equal called true)))
    (test :array
      (fn []
        (def called false)
        (.each _ [true] (fn [] (set! called true)))
        (equal called true)))))
