(ns hu.test.misc
  (:require
    [assert :refer [equal]]
    [hu.lib.misc :as _]
    [hu.lib.common :refer [number?]]))

(suite :noop
  (fn []
    (test :basic
      (fn []
        (equal (.noop _) nil)))))

(suite :global
  (fn []
    (test :basic
      (fn []
        (if (.-browser? _)
          (equal (.-*global _) window)
          (equal (.-*global _) global))))))

(suite :now
  (fn []
    (test :basic
      (fn []
        (equal (number? (.now _)) true)))))

(suite :isBrowser
  (fn []
    (test :basic
      (fn []
        (if (.-browser? _)
          (equal (.-browser? _) true)
          (equal (.-browser? _) false))))))
