(ns hu.test.object
  (:require
    [assert :refer [equal deep-equal not-equal]]
    [hu.lib.hu :as _]))

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

(suite :map
  (fn []
    (test :basic
      (fn []
        (deep-equal (.to-object _ :a 1 :b 2) {:a 1 :b 2})))
    (test :nested
      (fn []
        (not-equal (.to-object _ :a {:b 2}) {:a {:b 2}})))))
