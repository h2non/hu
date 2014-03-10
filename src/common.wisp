(ns hu.lib.common)

(def ^:private obj->str
  (.-to-string (.-prototype Object)))

(def ^boolean browser?
  (identical? (typeof window) "object"))

(defn- ->str
  [x] ((.-call obj->str) x))

(defn ^boolean null?
  [x] (identical? x null))

(defn ^boolean undef?
  [x]
  (or
    (identical? (typeof x) "undefined")
    (identical? x nil)
    (null? x)))

(defn ^boolean bool?
  [x] (identical? (typeof x) "boolean"))

(defn ^boolean number?
  [x] (identical? (typeof x) "number"))

(defn ^boolean symbol?
  [x] (identical? (typeof x) "symbol"))

(defn ^boolean function?
  [x] (identical? (typeof x) "function"))

(defn ^boolean string?
  [x] (identical? (->str x) "[object String]"))

(defn ^boolean date?
  [x] (identical? (->str x) "[object Date]"))

(defn ^boolean regexp?
  [x] (identical? (->str x) "[object RegExp]"))

(defn ^boolean object?
  [x] (identical? (->str x) "[object Object]"))

(defn ^boolean array?
  [x] (identical? (->str x) "[object Array]"))

(defn ^boolean error?
  [x] (identical? (->str x) "[object Error]"))

(defn ^boolean mutable?
  [x]
  (or
    (object? x)
    (array? x)
    (error? x)
    (date? x)
    (function? x)))

(defn ^boolean empty?
  [x]
  (or
    (undef? x)
    (identical? (.-length x) 0)))

(defn ^boolean primitive?
  [x]
  (or
    (undef? x)
    (bool? x)
    (string? x)
    (number? x)
    (symbol? x)))

(defn ^boolean iterable?
  [x] (or (mutable? x)))
