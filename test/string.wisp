(ns hu.test.string
  (:require
    [assert :refer [equal deep-equal]]
    [hu.lib.string :as _]))

(suite :lines
  (fn []
    (test :valid
      (fn []
        (equal (.-length (.lines _ "line\nanother")) 2)
        (equal (.-length (.lines _ "line\ranother")) 2)))))
