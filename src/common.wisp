(ns hu.src.common)

(def ^:private to-str
  (.-to-string (.-prototype Object)))

(def is-browser
  (identical? (typeof window) "object"))

(defn is-null
  [x] (identical? x null))

(defn is-undef
  [x] (or
        (identical? (typeof x) "undefined")
        (identical? x nil)
        (is-null x)))

(defn is-bool
  [x] (identical? (typeof x) "boolean"))

(defn is-number
  [x] (identical? (typeof x) "number"))

(defn is-symbol
  [x] (identical? (typeof x) "symbol"))

(defn is-function
  [x] (identical? (typeof x) "function"))

(defn is-string
  [x] (identical? (to-str x) "[object String]"))

(defn is-date
  [x] (identical? (to-str x) "[object Date]"))

(defn is-regexp
  [x] (identical? (to-str x) "[object RegExp]"))

(defn is-object
  [x] (identical? (to-str x) "[object Object]"))

(defn is-array
  [x] (identical? (to-str x) "[object Array]"))

(defn is-error
  [x] (identical? (to-str x) "[object Error]"))

(defn is-mutable
  [x] (or
        (is-object x)
        (is-array x)
        (is-date x)))

(defn is-empty
  [x] (or
        (is-undef x)
        (identical? (.-length x) 0)))

(defn is-primitive
  [x] (or
        (is-undef x)
        (is-bool x)
        (is-string x)
        (is-number x)
        (is-symbol x)))
