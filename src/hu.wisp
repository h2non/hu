(ns hu.src.index
  (:require
    [hu.src.common :as common]
    [hu.src.string :as string]
    [hu.src.number :as number]
    [hu.src.array :as array]
    [hu.src.object :as object]
    [hu.src.function :as fn]))

(def ^:private hu
  (set! (.-exports module)
    (apply (.-extend object)
      [nil common string number array object fn])))

(set! (.-VERSION hu) :0.1.0)
