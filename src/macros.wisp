(ns hu.lib.macros
  (:require
    [hu.lib.function :refer [curry compose]]
    [hu.lib.common :refer [string? array? object?]]))

(defmacro str
  [x expr]
  `(if (string? x) ~expr ~x))

(defmacro arr
  [x expr]
  `(if (array? x) ~expr ~x))

(defmacro obj
  [x expr]
  `(if (object? x) ~expr ~x))

(defmacro ?
  [x y]
  `(identical? ~x ~y))

(defmacro not?
  [x y]
  `(if (? ~x ~y) false true))

(defmacro unless
  [condition form]
  (list 'if condition nil form))

(defmacro when
  [condition form eform]
  (list 'if condition form eform))

(defmacro defcurry
  [name & args]
  (cond ; little hack for the wisp compiler
    (string? (.get-prototype-of Object (aget args 0)))
      (.shift args))
  `(defn ~name
      [& args]
        (apply (curry (fn ~@args)) args)))

(defmacro defcompose
  [name & args]
  `(def ~name (compose (fn ~@args))))
