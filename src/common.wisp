(ns hu.src.common)

(def ^:private to-str
  (.-to-string (.-prototype Object)))

(def is-browser
  (identical? (typeof window) "object"))

(defn is-number
  [x] (identical? (typeof x) "number"))

(defn is-bool
  [x] (identical? (typeof x) "boolean"))

(defn is-string
  [x] (identical? (to-str x) "[object String]"))

(defn is-date
  [x] (identical? (to-str x) "[object Date]"))

(defn is-object
  [x] (identical? (to-str x) "[object Object]"))

(defn is-array
  [x] (identical? (to-str x) "[object Array]"))

(defn is-mutable
  [x] (or
        (is-object x) 
        (is-array x) 
        (is-date x)))

(defn is-empty
  [x] (or
        (identical? x undefined)
        (identical? x null)
        (identical? x nil)
        (identical? (.-length x) 0)))