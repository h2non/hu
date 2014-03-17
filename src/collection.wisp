(ns hu.lib.collection
  (:require
    [hu.lib.type :refer [object? array? empty? iterable? not-empty?]]
    [hu.lib.object :refer [keys filter]]))

(defcurry ^void each
  "Iterates over elements of an iterable object,
  executing the callback for each element"
  [clt cb]
  (when (iterable? clt)
    (.for-each (keys clt)
      (fn [index]
        (cb (aget clt index) index clt)))) clt)

(def ^void for-each each)

(defn ^number size
  "Gets the size of the given collection"
  [clt]
  (if (iterable? clt)
    (if (object? clt)
      (.-length (keys clt))
      (.-length clt)) 0))

(defn ^object compact
  "Returns a new collection which
  contains only the not empty values"
  [clt]
  (when (array? clt)
    (.filter clt not-empty?)
    (filter clt not-empty?)))

(def ^mixed clean compact)
