(ns hu.lib.object
  (:require [hu.lib.common :refer [object? iterable?]]))

(def ^:private has-own
  (.-has-own-property (.-prototype Object)))

(defn has
  "Checks if the specified property name exists as a
  own property of the given object"
  [obj prop]
  ((.-call has-own) obj, prop))

(defn extend [target & origins]
  "Assigns own enumerable properties of source
  object(s) to the destination object."
  (set! target (if (object? target) target {} ))
  (origins.reduce
    (fn [origin o index]
      (if (object? origin)
        (.for-each (.keys Object origin)
          (fn [name]
            (set! (aget target name) (aget origin name)))))
    (aget origins (+ index 1))) (aget origins 0)) target)

(defn each
  "Iterates over elements of a collection,
  executing the callback for each element."
  [obj cb ctx]
  (if (iterable? obj)
    (.for-each (.keys Object obj)
      (fn [index]
        (cb (aget obj index) index obj)))) obj)

(defn clone
  "Creates a clone of a mutable object"
  [obj]
  (set! obj (if (object? obj) obj {} )) obj)

