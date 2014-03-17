(ns hu.lib.type
  (:require
    [hu.lib.misc :refer [browser? *global]]))

(def ^:private obj->str
  (.-to-string (.-prototype Object)))

(defn ^:private ->str
  [x] ((.-call obj->str) x))

(defn ^boolean null?
  "Check if the given value is null
  Performs a strict type coercion comparison"
  [x] (? x null))

(defn ^boolean undef?
  "Check if the given value is null or undefined
  Performs a strict type coercion comparison"
  [x]
  (or
    (? (typeof x) "undefined")
    (null? x)))

(defn ^boolean bool?
  "Check if the given value is boolean type"
  [x]
  (or
    (? x true)
    (? x false)
    (? (.call to-string x) "[object Boolean]")))

(defn ^boolean number?
  "Check if the given value is number type"
  [x] (? (->str x) "[object Number]"))

(defn ^boolean finite?
  "Check if the given value is a finite number"
  [x]
  (.finite? *global (parse-float x)))

(defn ^number NaN?
  "Is it NaN (not a number)?
  More accurate than the native isNaN function"
  [x]
  (if (identical? x x) false true))

(defn ^boolean symbol?
  "Check if the given value is a symbol type"
  [x] (? (->str x) "[object Symbol]"))

(defn ^boolean string?
  "Check if the given value is a string type"
  [x] (? (->str x) "[object String]"))

(defn ^boolean date?
  "Check if the given value is a date type"
  [x] (? (->str x) "[object Date]"))

(defn ^boolean reg-exp?
  "Check if the given value is a regexp type"
  [x] (? (->str x) "[object RegExp]"))

(def ^boolean pattern? reg-exp?)

(defn ^boolean args?
  "Check if the given value is a arguments object type"
  [x] (? (->str x) "[object Arguments]"))

(def ^boolean arguments? args?)

(defn ^boolean function?
  "Check if the given value is a function type"
  [x] (? (typeof x) "function"))

(def ^boolean fn? function?)

(defn ^boolean object?
  "Check if the given value is a object type"
  [x] (? (->str x) "[object Object]"))

(def ^:boolean array?
  "Check if the given value is an array type"
  (if (fn? (.-isArray Array))
    (.-isArray Array)
    (fn [x] (? (->str x) "[object Array]"))))

(defn ^boolean error?
  "Check if the given value is an Error object instance"
  [x] (? (->str x) "[object Error]"))

(defn ^boolean plain-object?
  "Checks if the given value is a native object type
  (it was createdd by the Object native constructor)"
  [x]
  (and
    (object? x)
    (object? (.get-prototype-of Object x))
    (null? (.get-prototype-of Object (.get-prototype-of Object x)))))

(defn ^boolean element?
  "Checks if the given value is a DOM element object instance"
  [x]
  (if browser?
    (>= (.index-of (->str x) :Element) 0)
    false))

(defn ^boolean mutable?
  "Checks if the given value is a mutable data type.
  Objects, arrays, date objects, arguments objects and
  functions are considered mutable data types"
  [x]
  (or
    (object? x)
    (array? x)
    (error? x)
    (args? x)
    (date? x)
    (function? x)))

(defn ^boolean empty?
  "Checks if the given value is empty.
  Arrays, strings, or arguments objects with
  a length of 0 and objects with no own enumerable
  properties are considered empty values"
  [x]
  (or
    (undef? x)
    (if (object? x)
      (if (? (.-length (.keys Object x)) 0) true false) false)
    (? (.-length x) 0)))

(defn ^boolean primitive?
  "Checks if the given value is a primitive value type.
  Strings, numbers, booleans, symbols and null are
  considered primitives values"
  [x]
  (or
    (null? x)
    (bool? x)
    (reg-exp? x)
    (string? x)
    (number? x)
    (symbol? x)))

(defn ^boolean iterable?
  "Checks if the given value can be iterated.
  Objects, arrays, and arguments objects are
  considered iterables data types"
  [x]
  (or
    (object? x)
    (array? x)
    (args? x)))

(def ^boolean can-iterate iterable?)
