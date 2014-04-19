(ns hu.lib.object
  (:require
    [hu.lib.type
      :refer [date? array? object? fn?]]))

(def ^:private has-own
  (.-has-own-property (.-prototype Object)))

(defcurry ^boolean has
  "Check if an object has the given own enumerable property"
  [obj prop]
  ((.-call has-own) obj, prop))

(defn ^array keys
  "Returns a sequence of the map's keys"
  [obj]
  (.keys Object obj))

(defn ^array vals
  "Returns a sequence of the map's values"
  [obj]
  (.map (keys obj)
    (fn [key] (get obj key))))

(defn ^object extend
  "Assigns own enumerable properties of source object(s)
  to the destination object"
  [target & origins]
  (def obj (when (object? target) target {}))
  (.reduce origins
    (fn [origin o index]
      (when (object? origin)
        (.for-each (keys origin)
          (fn [name]
            (set! (aget obj name) (aget origin name)))))
      (aget origins (+ index 1)))
    (aget origins 0)) obj)

(def ^object assign extend)

(defn ^object mixin
  "Adds function properties of a source object
  to the destination object"
  [target & origins]
  (def obj (when (object? target) target {}))
  (.reduce origins
    (fn [origin _ index]
      (when (object? origin)
        (.for-each (keys origin)
          (fn [name]
            (cond (fn? (aget origin name))
              (set! (aget obj name) (aget origin name))))))
      (aget origins (+ index 1)))
    (aget origins 0)) obj)

(defn ^object clone
  "Creates a clone of the given object"
  [obj]
  (when (array? obj)
    (.slice obj)
  (when (object? obj)
    (extend {} obj)
  (when (date? obj)
    (Date. (.get-time obj)) obj))))

(defn ^object key-values
  "Returns a two dimensional array of an object’s key-value pairs"
  [obj]
  (.map (keys obj)
    (fn [key] [key (get obj key)])))

(def ^fn pairs key-values)

(defn ^object ->object
  "Creates an object of given arguments
  Odd indexed arguments are used for keys and evens for values"
  [& pairs]
  (loop [key-values pairs
         result {}]
    (if (.-length key-values)
      (do
        (set! (aget result (aget key-values 0))
              (aget key-values 1))
        (recur (.slice key-values 2) result)) result)))

; to do: recursive deep merge
(def ^:private **oproto** (.-prototype Object))

(defn ^object merge
  "Similar to `extend`, it returns an object that consists
  of the rest of the maps conj-ed onto the first.
  If a key occurs in more than one map, the mapping from
  the latter (left-to-right) will be the mapping in the result"
  [& args]
  (.create Object
    **oproto**
    (.reduce args
      (fn [descriptor obj]
        (when (object? obj)
          (.for-each (keys obj)
            (fn [key]
              (set!
                (get descriptor key)
                (.get-own-property-descriptor Object obj key))))) descriptor) {})))

(defcurry ^object map
  "Maps object values by applying with the value return
  of each callback call on each one"
  [source cb]
  (.reduce
    (keys source)
      (fn [target key]
        (set!
          (aget target key) (cb (aget source key) key source)) target) source))

(def ^object map-values map)

(defcurry ^object filter
  "Iterates over properties of an object,
  returning an filtered new object of all
  elements where the callback returns true"
  [source cb]
  (let [target {}]
    (.reduce
      (keys source)
      (fn [target key]
        (cond (cb (aget source key) key source)
          (set! (aget target key) (aget source key))) target) target) target))

(def ^object filter-values filter)
