(ns hu.lib.macros
  (:require
    [hu.lib.function :refer [curry compose]]
    [hu.lib.type :refer [string? array? number? undef? object?]]))

(defmacro str?
  [x expr]
  `(if (string? ~x) ~expr ~x))

(defmacro arr?
  [x expr]
  `(if (array? ~x) ~expr ~x))

(defmacro obj?
  [x expr]
  `(if (object? ~x) ~expr ~x))

(defmacro num?
  [x expr]
  `(if (number? ~x) ~expr ~x))

(defmacro ?
  [x y]
  `(identical? ~x ~y))

(defmacro not?
  [x y]
  `(if (? ~x ~y) false true))

(defmacro def?
  [x]
  `(if (undef? ~x) false true))

(defmacro unless
  [condition form]
  (list 'if condition nil form))

(defmacro when
  [condition form eform]
  (list 'if condition form eform))

(defmacro defcurry
  [name & etc]
  (let [doc? (string? (first etc))
        doc (if doc? (first etc) " ")
        body (if doc? (rest etc) etc)]
    `(defn ~name
       ~doc
       [& args]
       (apply (curry (fn ~@body)) args))))

(defmacro defcompose
  [name & etc]
  (let [doc? (string? (first etc))
        doc (if doc? (first etc) " ")
        body (if doc? (rest etc) etc)]
    `(defn ~name
       ~doc
       [& args]
       (apply (compose (fn args) args)))))
