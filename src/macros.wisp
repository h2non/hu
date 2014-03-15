(ns hu.lib.macros
  (:require [hu.lib.function :refer [curry compose]]))

(defmacro str
  [x expr]
  `(if (string? x) ~expr x))

(defmacro arr
  [x expr]
  `(if (array? x) ~expr x))

(defmacro defcurry
  [name & args]
  `(def ~name (curry (fn ~@args))))

(defmacro defcompose
  [name & args]
  `(def ~name (compose (fn ~@args))))
