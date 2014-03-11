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
  [x]
  (or
    (identical? x true)
    (identical? x false)
    (identical? (.call to-string x) "[object Boolean]")))

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

(defn ^boolean dictionary?
  [form]
  (and
    (object? form)
    (object? (.get-prototype-of Object form))
    (nil? (.get-prototype-of Object (.get-prototype-of Object form)))))

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

(defn log
  [& more]
  (apply console.log more))

;
; Comparison
;

(defn- ^boolean equal?
  "Equality. Returns true if x equals y, false if not. Compares
  numbers and collections in a type-independent manner. Clojure's
  immutable data structures define -equiv (and thus =) as a value,
  not an identity, comparison."
  ([x] true)
  ([x y] (or (identical? x y)
             (cond (nil? x) (nil? y)
                   (nil? y) (nil? x)
                   (string? x) (and (string? y) (identical? (.to-string x)
                                                            (.to-string y)))
                   (number? x) (and (number? y) (identical? (.value-of x)
                                                            (.value-of y)))
                   (fn? x) false
                   (bool? x) false
                   (date? x) (date-equal? x y)
                   (vector? x) (vector-equal? x y [] [])
                   (re-pattern? x) (pattern-equal? x y)
                   :else (dictionary-equal? x y))))
  ([x y & more]
   (loop [previous x
          current y
          index 0
          count (.-length more)]
    (and (equivalent? previous current)
         (if (< index count)
          (recur current
                 (get more index)
                 (inc index)
                 count)
          true)))))

(def deep-equal? equal?)
