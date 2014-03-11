(ns hu.lib.object
  (:require [hu.lib.common :refer [object? iterable?]]))

(def ^:private has-own
  (.-has-own-property (.-prototype Object)))

(defn has
  "Checks if the specified property name exists as a
  own property of the given object"
  [obj prop]
  ((.-call has-own) obj, prop))

(defn extend [target & origins]
  "Assigns own enumerable properties of source
  object(s) to the destination object."
  (set! target (if (object? target) target {} ))
  (origins.reduce
    (fn [origin o index]
      (if (object? origin)
        (.for-each (.keys Object origin)
          (fn [name]
            (set! (aget target name) (aget origin name)))))
    (aget origins (+ index 1))) (aget origins 0)) target)

(defn each
  "Iterates over elements of a collection,
  executing the callback for each element."
  [obj cb ctx]
  (if (iterable? obj)
    (.for-each (.keys Object obj)
      (fn [index]
        (cb (aget obj index) index obj)))) obj)

(defn clone
  "Creates a clone of a mutable object"
  [obj]
  (set! obj (if (object? obj) obj {} )) obj)

(defn keys
  "Returns a sequence of the map's keys"
  [dictionary]
  (.keys Object dictionary))

(defn vals
  "Returns a sequence of the map's values."
  [dictionary]
  (.map (keys dictionary)
        (fn [key] (get dictionary key))))

(defn key-values
  [dictionary]
  (.map (keys dictionary)
        (fn [key] [key (get dictionary key)])))

(defn dictionary
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
    (.keys Object source)
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
    (fn [descriptor dictionary]
      (if (object? dictionary)
        (.for-each
         (Object.keys dictionary)
         (fn [key]
           (set!
            (get descriptor key)
            (Object.get-own-property-descriptor dictionary key)))))
      descriptor)
    (Object.create Object.prototype))))

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
