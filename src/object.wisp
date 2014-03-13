(ns hu.lib.object
  (:require [hu.lib.common :refer [object? fn? iterable?]]))

(def ^:private has-own
  (.-has-own-property (.-prototype Object)))

(defn ^boolean has
  [obj prop]
  ((.-call has-own) obj, prop))

(defn ^array keys
  [obj]
  (.keys Object obj))

(defn ^array vals
  [obj]
  (.map (keys obj)
    (fn [key] (get obj key))))

(defn ^object extend
  [target & origins]
  (set! target (if (object? target) target {}))
  (origins.reduce
    (fn [origin o index]
      (if (object? origin)
        (.for-each (keys origin)
          (fn [name]
            (set! (aget target name) (aget origin name)))))
      (aget origins (+ index 1)))
    (aget origins 0)) target)

(def ^object assign extend)

(defn ^object mixin
  [target & origins]
  (set! target (if (object? target) target {}))
  (origins.reduce
    (fn [origin _ index]
      (if (object? origin)
        (.for-each (keys origin)
          (fn [name]
            (cond (fn? (aget origin name))
              (set! (aget target name) (aget origin name))))))
      (aget origins (+ index 1)))
    (aget origins 0)) target)

(defn ^void each
  [obj cb ctx]
  (if (iterable? obj)
    (.for-each (keys obj)
      (fn [index]
        (cb (aget obj index) index obj)))) obj)

(def ^void for-each each)

(defn ^object clone
  [obj]
  (set! obj (if (object? obj) obj {} )) obj)

(defn ^object key-values
  [obj]
  (.map (keys obj)
        (fn [key] [key (get obj key)])))

(defn obj
  "Creates dictionary of given arguments. Odd indexed arguments
  are used for keys and evens for values"
  [& pairs]
  ; TODO: We should convert keywords to names to make sure that keys are not
  ; used in their keyword form.
  (loop [key-values pairs
         result {}]
    (if (.-length key-values)
      (do
        (set! (aget result (aget key-values 0))
              (aget key-values 1))
        (recur (.slice key-values 2) result))
      result)))

(defn map
  "Maps dictionary values by applying `cb` to each one"
  [source cb]
  (.reduce
    (keys source)
      (fn [target key]
        (set! (get target key) (cb (get source key)))
        target) {}))

(defn merge
  "Returns a dictionary that consists of the rest of the maps conj-ed onto
  the first. If a key occurs in more than one map, the mapping from
  the latter (left-to-right) will be the mapping in the result."
  []
  (Object.create
   Object.prototype
   (.reduce
    (.call Array.prototype.slice arguments)
    (fn [descriptor obj]
      (if (object? obj)
        (.for-each
         (keys obj)
         (fn [key]
           (set!
            (get descriptor key)
            (Object.get-own-property-descriptor obj key)))))
      descriptor)
    (Object.create Object.prototype))))

(defn ^boolean equal?
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
    (and (equal? previous current)
         (if (< index count)
          (recur current
                 (get more index)
                 (inc index)
                 count)
          true)))))

(def deep-equal? equal?)

(defn- ^boolean object-equal?
  [x y]
  (and (object? x)
       (object? y)
       (let [x-keys (keys x)
             y-keys (keys y)
             x-count (.-length x-keys)
             y-count (.-length y-keys)]
         (and (identical? x-count y-count)
              (loop [index 0
                     count x-count
                     keys x-keys]
                (if (< index count)
                  (if (equivalent? (get x (get keys index))
                                   (get y (get keys index)))
                    (recur (inc index) count keys)
                    false)
                  true))))))
