(ns hu.src.index
  (:require
    [hu.src.equality :as equality]
    [hu.src.collection :as collection]
    [hu.src.type :as type]
    [hu.src.string :as string]
    [hu.src.number :as number]
    [hu.src.object :as object]
    [hu.src.array :as array]
    [hu.src.function :as *function]
    [hu.src.misc :as misc]))

(def ^:private hu
  (set! (.-exports module)
    (apply (.-extend object)
      [nil
       misc
       type
       string
       number
       array
       object
       *function
       collection
       equality])))

(set! (.-VERSION hu) :0.1.0)
