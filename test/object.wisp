(ns hu.test.object
  (:require
    [assert :refer [equal deep-equal not-equal not-deep-equal]]
    [hu.lib.object :as _]))

(suite :has
  (fn []
    (test :basic
      (fn []
        (equal (.has _ {:a true} :a) true)
        (equal (.has _ {:a false} :b) false)))))

(suite :keys
  (fn []
    (test :basic
      (fn []
        (deep-equal (.keys _ {:a true}) [:a])
        (deep-equal (.keys _ {:a false :b true}) [:a :b])))))

(suite :vals
  (fn []
    (test :basic
      (fn []
        (deep-equal (.vals _ {:a true}) [true])
        (deep-equal (.vals _ {:a false :b true}) [false true])))))

(suite :extend
  (fn []
    (test :basic
      (fn []
        (deep-equal
          (.extend _
            {:a true} {:b false})
            {:a true :b false})
        (deep-equal
          (.extend _
            {:a true} {:b false })
            {:a true :b false})))
    (test :multiple
      (fn []
        (deep-equal
          (.extend _
            {:a 1} {:b 2} {:c 3})
            {:a 1 :b 2 :c 3})
        (deep-equal
          (.extend _
            {:a 1} {:b 2} {:c 3})
            {:a 1 :b 2 :c 3})))))

(suite :mixin
  (fn []
    (test :valid
      (fn []
        (equal
          (.has _
            (.mixin _ {:a (fn [])} {:b (fn [])}) "a") true)
        (equal
          (.has _
            (.mixin _ {:a (fn [])} {:b (fn [])}) "b") true)))
    (test :invalid
      (fn []
        (equal
          (.has _
            (.mixin _ {:a (fn [])} {:b false}) "a") true)
        (equal
          (.has _
            (.mixin _ {:a (fn [])} {:b false}) "b") false)))))

(suite :clone
  (fn []
    (test :inmutable
      (fn []
        (equal (.clone _ true) true)))
    (test :date
      (fn []
        (not-equal (.clone _ (Date.)) (Date.))))
    (test :object
      (fn []
        (not-equal (.clone _ {:a true}) {:a true})))
    (test :array
      (fn []
        (not-equal (.clone _ [1 2]) [1 2])))))

(suite :keyValues
  (fn []
    (test :basic
      (fn []
        (deep-equal (.key-values _ {:a 1 :b 2}) [[:a 1][:b 2]])))
    (test :nested
      (fn []
        (not-equal (.key-values _ {:a {:b 2}}) [[:a {:b 2}]])))))

(suite :toObject
  (fn []
    (test :basic
      (fn []
        (deep-equal (.to-object _ :a 1 :b 2) {:a 1 :b 2})))
    (test :nested
      (fn []
        (not-equal (.to-object _ :a {:b 2}) {:a {:b 2}})))))

(suite :map
  (fn []
    (test :basic
      (fn []
        (deep-equal
          (.map _ {:a 1 :b 2} (fn [n] (* n 2))) {:a 2 :b 4})))))

(suite :filter
  (fn []
    (test :basic
      (fn []
        (deep-equal
          (.filter _ {:a 1 :b 2} (fn [n] (> n 1))) {:b 2})))))

(suite :merge
  (fn []
    (test :basic
      (fn []
        (deep-equal
          (.merge _ {:a 1 :b 2} {:a 2}) {:a 2 :b 2})))
    (test :deep
      (fn []
        (deep-equal
          (.merge _ {:a {:b 2 :c 3}} {:a {:b 1}}) {:a {:b 1}})))))

