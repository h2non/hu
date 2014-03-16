(ns hu.test.function
  (:require
    [assert :refer [equal deep-equal]]
    [hu.lib.function :as _]
    [hu.lib.common :refer [fn?]]))

(suite :constant
  (fn []
    (test :definition
      (fn []
        (equal
          (fn? (.constant _ :value)) true)
        (equal
          ((.constant _ :value)) :value)))))

(suite :apply
  (fn []
    (test :valid
      (fn []
        (equal
          (.apply _ (fn [x] x) [true]) true)
        (equal
          (.apply _ (fn [x n] n) [nil 3.14]) 3.14)))))

(suite :bind
  (fn []
    (test :valid
      (fn []
        (equal
          ((.bind _ (fn [] (.-x this)) {:x true})) true)
        (equal
          ((.bind _ (fn [] (.-n this)) nil)) nil)))))

(suite :partial
  (fn []
    (test :unique
      (fn []
        (equal
          ((.partial _ (fn [a] a)) true) true)))
    (test :multiple
      (fn []
        (equal
          ((.partial _ (fn [a b c] c) :a :b) :c) :c)))))

(suite :curry
  (fn []
    (test :unique
      (fn []
        (equal
          ((.curry _ (fn [a] a)) true) true)))
    (test :multiple
      (fn []
        (equal
          (((.curry _
            (fn [a b c] c) :a) :b) :c) :c)))))

(suite :wrap
  (fn []
    (test :unique
      (fn []
        (equal
          ((.wrap _
            (fn [] :hu)
            (fn [f] (+ "hi " (f))))) "hi hu")))
    (test :arguments
      (fn []
        (equal
          ((.wrap _
            (fn [] :hu)
            (fn [f e] (+ "hi " (f) e)) "!")) "hi hu!")))))

(suite :compose
  (fn []
    (test :basic
      (fn []
        (equal
          ((.compose _
            (fn [] :hu)
            (fn [x] (+ "hi " x)))) "hi hu")))
    (test :arguments
      (fn []
        (equal
          ((.compose _
            (fn [x] (+ :hu x))
            (fn [x] (+ "hi " x))
            (fn [x] (+ "say: " x))) "!") "say: hi hu!")))))

(suite :once
  (fn []
    (test :basic
      (fn []
        (let [c 0
              f (.once _ (fn [] (set! c (+ c 1))))]
              (equal (f) 1)
              (equal (f) 1))))
    (test :arguments
      (fn []
        (let [f (.once _ (fn [n] (+ n 1)))]
              (equal (f 1) 2)
              (equal (f 2) 2))))))

(suite :times
  (fn []
    (test :basic
      (fn []
        (let [c 0
              f (.times _ (fn [] (set! c (+ c 1))) 2)]
              (equal (f) 1)
              (equal (f) 2)
              (equal (f) 2))))
    (test :arguments
      (fn []
        (let [f (.times _ (fn [n] (+ n 1)) 2)]
              (equal (f 1) 2)
              (equal (f 2) 3)
              (equal (f 2) 3))))))

(suite :delay
  (fn []
    (test :basic
      (fn [done]
        (.delay _ (fn [] (done)) 50)))
    (test :arguments
      (fn [done]
        (.delay _ (fn [x] (equal x :x) (done)) 50 :x)))))

(suite :defer
  (fn []
    (test :basic
      (fn [done]
        ((.defer _ (fn [] (done)) 50))))
    (test :arguments
      (fn [done]
        ((.defer _ (fn [x] (equal x :x) (done)) 50 :x)))
      (fn [done]
        ((.defer _ (fn [x y]
          (equal x :x)
          (equal y :y) (done)) 50 :x) :y)))))

