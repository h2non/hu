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

(suite :head
  (fn []
    (test :invalid
      (fn []
        (equal (.head _ nil) nil)
        (equal (.head _ true) true)
        (equal (.head _ :a) :a)))
    (test :basic
      (fn []
        (equal (.head _ [1 2]) 1)
        (equal (.head _ [:a :b]) :a)
        (equal (.head _ []) nil)
        (deep-equal
          (.head _ [{:a 1} {:b 2}]) {:a 1})))))

(suite :tail
  (fn []
    (test :invalid
      (fn []
        (equal (.tail _ nil) nil)
        (equal (.tail _ true) true)
        (equal (.tail _ :a) :a)))
    (test :basic
      (fn []
        (deep-equal (.tail _ [1 2 3]) [2 3])
        (deep-equal (.tail _ [:a :b :c]) [:b :c])
        (deep-equal (.tail _ []) [])
        (deep-equal (.tail _ [{:a 1} {:b 2}]) [{:b 2}])))))

(suite :last
  (fn []
    (test :invalid
      (fn []
        (equal (.last _ nil) nil)
        (equal (.last _ true) true)
        (equal (.last _ :a) :a)))
    (test :basic
      (fn []
        (deep-equal (.last _ [1 2 3]) [3])
        (deep-equal (.last _ [:a :b :c]) [:c])
        (deep-equal (.last _ []) [])
        (deep-equal (.last _ [{:a 1} {:b 2}]) [{:b 2}])))))

(suite :initial
  (fn []
    (test :invalid
      (fn []
        (equal (.initial _ nil) nil)
        (equal (.initial _ true) true)
        (equal (.initial _ :a) :a)))
    (test :basic
      (fn []
        (deep-equal (.initial _ [1 2 3]) [1 2])
        (deep-equal (.initial _ [:a :b :c]) [:a :b])
        (deep-equal (.initial _ []) [])
        (deep-equal (.initial _ [{:a 1} {:b 2}]) [{:a 1}])))))
