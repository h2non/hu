(ns hu.lib.common)

(def ^:private obj->str
  (.-to-string (.-prototype Object)))

(def ^:private native-finite (.-is-finite this))

(def ^void noop (fn []))

(def ^number now (.-now Date))

(defn ^:private ->str
  [x] ((.-call obj->str) x))

(defn ^boolean null?
  [x] (? x null))

(defn ^boolean undef?
  [x]
  (or
    (? (typeof x) "undefined")
    (null? x)))

(defn ^boolean bool?
  [x]
  (or
    (? x true)
    (? x false)
    (? (.call to-string x) "[object Boolean]")))

(defn ^boolean number?
  [x] (? (typeof x) "number"))

(defn ^boolean finite?
  [x] (native-finite (parse-float x)))

(defn ^boolean symbol?
  [x] (? (typeof x) "symbol"))

(defn ^boolean function?
  [x] (? (typeof x) "function"))

(def ^boolean fn? function?)

(defn ^boolean string?
  [x] (? (->str x) "[object String]"))

(defn ^boolean date?
  [x] (? (->str x) "[object Date]"))

(defn ^boolean reg-exp?
  [x] (? (->str x) "[object RegExp]"))

(def ^boolean pattern? reg-exp?)

(defn ^boolean object?
  [x] (? (->str x) "[object Object]"))

(defn ^boolean args?
  [x] (? (->str x) "[object Arguments]"))

(def ^:boolean array?
  (if (fn? (.-isArray Array))
    (.-isArray Array)
    (fn [x] (? (->str x) "[object Array]"))))

(defn ^boolean error?
  [x] (? (->str x) "[object Error]"))

(defn ^boolean plain-object?
  [x]
  (and
    (object? x)
    (object? (.get-prototype-of Object x))
    (null? (.get-prototype-of Object (.get-prototype-of Object x)))))

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
    (? (.-length x) 0)))

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

(def ^boolean browser?
  (do
    (and
      (? (typeof window) "object")
      (fn? (.-HTMLElement window)))))
