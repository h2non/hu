(ns hu.lib.collection
  (:require
    [hu.lib.type :refer [object? iterable?]]
    [hu.lib.object :refer [keys]]))

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
