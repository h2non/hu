(ns hu.lib.common)

(def ^:private obj->str
  (.-to-string (.-prototype Object)))

(def ^:private native-finite (.-is-finite this))

(def ^boolean browser?
  (identical? (typeof window) "object"))

(def ^void noop (fn []))

(def ^number now (.-now Date))

(defn ^:private ->str
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
  [x]
  (or
    (identical? x true)
    (identical? x false)
    (identical? (.call to-string x) "[object Boolean]")))

(defn ^boolean number?
  [x] (identical? (typeof x) "number"))

(defn ^boolean finite?
  [x] (native-finite (parse-float x)))

(defn ^boolean symbol?
  [x] (identical? (typeof x) "symbol"))

(defn ^boolean function?
  [x] (identical? (typeof x) "function"))

(def ^boolean fn? function?)

(defn ^boolean string?
  [x] (identical? (->str x) "[object String]"))

(defn ^boolean date?
  [x] (identical? (->str x) "[object Date]"))

(defn ^boolean reg-exp?
  [x] (identical? (->str x) "[object RegExp]"))

(defn ^boolean object?
  [x] (identical? (->str x) "[object Object]"))

(defn ^boolean args?
  [x] (identical? (->str x) "[object Arguments]"))

(def ^:boolean array?
  (if (fn? (.-isArray Array))
    (.-isArray Array)
    (fn [x] (identical? (->str x) "[object Array]"))))

(defn ^boolean error?
  [x] (identical? (->str x) "[object Error]"))

(defn ^boolean plain-object?
  [x]
  (and
    (object? x)
    (object? (.get-prototype-of Object x))
    (nil? (.get-prototype-of Object (.get-prototype-of Object x)))))

(defn ^boolean element?
  [x]
  (if browser?
    (>= (.index-of (->str x) :Element) 0)
    false))

(defn ^boolean mutable?
  [x]
  (or
    (object? x)
    (array? x)
    (error? x)
    (args? x)
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
    (null? x)
    (bool? x)
    (string? x)
    (number? x)
    (symbol? x)))

(defn ^boolean iterable?
  [x]
  (or
    (object? x)
    (array? x)
    (args? x)))

(defn log
  [& args]
  (.apply (.-log console) console args))
