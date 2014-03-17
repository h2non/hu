(ns hu.test.number
  (:require
    [assert :refer [equal deep-equal]]
    [hu.lib.number :as _]))

(suite :max
  (fn []
    (test :basic
      (fn []
        (equal (.max _ 2, 4, 8) 8)
        (equal (.max _ 0.1 0.95) 0.95)))))

(suite :max
  (fn []
    (test :basic
      (fn []
        (equal (.min _ 2, 4, 8) 2)
        (equal (.min _ 0.1 0.95) 0.1)))))

(suite :abs
  (fn []
    (test :basic
      (fn []
        (equal (.abs _ -1.25) 1.25)
        (equal (.abs _ 10) 10)))))

(suite :odd
  (fn []
    (test :basic
      (fn []
        (equal (.odd _ 2) false)
        (equal (.odd _ 3) true)
        (equal (.odd _ -3) true)
        (equal (.odd _ 2.47) true)
        (equal (.odd _ 1.92) true)))))

(suite :even
  (fn []
    (test :basic
      (fn []
        (equal (.even _ 2) true)
        (equal (.even _ 3) false)
        (equal (.even _ -2) true)
        (equal (.even _ 2.47) false)
        (equal (.even _ 1.92) false)))))

(suite :lower
  (fn []
    (test :basic
      (fn []
        (equal (.lower _ 1 2) true)
        (equal (.lower _ 1 1) false)
        (equal (.lower _ 1 nil) false)
        (equal (.lower _ 2 :a) false)
        (equal (.lower _ 1.92 1.95) true)))))

(suite :higher
  (fn []
    (test :basic
      (fn []
        (equal (.higher _ 1 2) false)
        (equal (.higher _ 1 1) false)
        (equal (.higher _ 1 nil) false)
        (equal (.higher _ 2 :a) false)
        (equal (.higher _ 1.95 1.92) true)))))

(suite :inc
  (fn []
    (test :basic
      (fn []
        (equal (.inc _ 1) 2)
        (equal (.inc _ 5.25) 6.25)
        (equal (.inc _ -3) -2)))))

(suite :dec
  (fn []
    (test :basic
      (fn []
        (equal (.dec _ 1) 0)
        (equal (.dec _ 5.25) 4.25)
        (equal (.dec _ -3) -4)))))

(suite :signum
  (fn []
    (test :basic
      (fn []
        (equal (.signum _ 3) 1)
        (equal (.signum _ -3) -1)
        (equal (.signum _ 0) 0)
        (equal (.signum _ -0) -0)))))

(suite :negate
  (fn []
    (test :basic
      (fn []
        (equal (.negate _ 3) -3)
        (equal (.negate _ -3) 3)
        (equal (.negate _ 3.14) -3.14)
        (equal (.negate _ 0) -0)))))

(suite :isNegative
  (fn []
    (test :basic
      (fn []
        (equal (.negative? _ 3) false)
        (equal (.negative? _ -3) true)
        (equal (.negative? _ 0) false)
        (equal (.negative? _ -0) false)))))

(suite :recip
  (fn []
    (test :basic
      (fn []
        (equal (.round Math (* (.recip _ 3) 10)) 3)
        (equal (.round Math (* (.recip _ -3) 10)) -3)))))

(suite :div
  (fn []
    (test :basic
      (fn []
        (equal (.div _ 9 3) 3)
        (equal (.div _ -9 -3) 3)))
    (test :curry
      (fn []
        (equal ((.div _ 9) 3) 3)
        (equal ((.div _ -9) -3) 3)))))
