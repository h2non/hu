(ns hu.lib.collection
  (:require
    [hu.lib.common :refer [date? array? object? fn? iterable?]]
    [hu.lib.object :refer [keys]]))

(defn ^void each
  "Iterates over elements of an iterable object,
  executing the callback for each element"
  [obj cb]
  (when (iterable? obj)
    (.for-each (keys obj)
      (fn [index]
        (cb (aget obj index) index obj)))) obj)

(def ^void for-each each)
