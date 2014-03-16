(ns hu.test.object
  (:require
    [assert :refer [equal]]
    [hu.lib.collection :as _]))

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

(suite :size
  (fn []
    (test :invalid
      (fn []
        (equal
          (.size _ :str) 0)
        (equal
          (.size _ nil) 0)))
    (test :array
      (fn []
        (equal
          (.size _ [1 2]) 2)))
    (test :object
      (fn []
        (equal
          (.size _ {:a 1 :b 2}) 2)))))
