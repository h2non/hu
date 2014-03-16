(ns hu.test.equality
  (:require
    [assert :refer [equal deep-equal not-equal not-deep-equal]]
    [hu.lib.equality :as _]))

(suite :isPatternEqual
  (fn []
    (test :basic
      (fn []
        (equal
          (.pattern-equal? _ #"[a-z]+" #"[a-z]+") true)
        (equal
          (.pattern-equal? _ #"[a-z]+" #"[0-9]+") false)))))

(suite :isDateEqual
  (fn []
    (test :basic
      (fn []
        (equal
          (.date-equal? _ (Date. 1) (Date. 1)) true)
        (equal
          (.date-equal? _ (Date.) (Date. 1)) false)))))

(suite :isArrayEqual
  (fn []
    (test :basic
      (fn []
        (equal
          (.array-equal? _ [1 2] [1 2]) true)
        (equal
          (.array-equal? _ [1 2] [1 3]) false)))))

(suite :isObjectEqual
  (fn []
    (test :basic
      (fn []
        (equal
          (.object-equal? _ {:a {:b 2 :c 3}} {:a {:b 2 :c 3}}) true)
        (equal
          (.object-equal? _ {:a {:b 2 :c 3}} {:a {:b 2 :c 1}}) false)))))

(suite :isEqual
  (fn []
    (test :null
      (fn []
        (equal
          (.equal? _ null null) true)
        (equal
          (.equal? _ null nil) false)))
    (test :boolean
      (fn []
        (equal
          (.equal? _ true true) true)
        (equal
          (.equal? _ false true) false)))
    (test :number
      (fn []
        (equal
          (.equal? _ 3.1 3.1) true)
        (equal
          (.equal? _ 3 4) false)))
    (test :string
      (fn []
        (equal
          (.equal? _ :a :a) true)
        (equal
          (.equal? _ :a :z) false)))
    (test :date
      (fn []
        (equal
          (.equal? _ (Date. 1) (Date. 1)) true)
        (equal
          (.equal? _ (Date.) (Date. 1)) false)))
    (test :regexp
      (fn []
        (equal
          (.equal? _ #"[a-z]+" #"[a-z]+") true)
        (equal
          (.equal? _ #"[a-z]+" #"[a-z0-9]+") false)))
    (test :array
      (fn []
        (equal
          (.equal? _ [1 2] [1 2]) true)
        (equal
          (.equal? _ [1 2] [1 3]) false)))
    (test :object
      (fn []
        (equal
          (.equal? _ {:a {:b 2 :c 3}} {:a {:b 2 :c 3}}) true)
        (equal
          (.equal? _ {:a {:b 2 :c 3}} {:a {:x 1}}) false)))))
