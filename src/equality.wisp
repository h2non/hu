(ns hu.lib.equality
  (:require
    [hu.lib.common
      :refer [date? array? object? fn? null? undef? string? number? bool? iterable? pattern? pattern-equal? date-equal?]]
    [hu.lib.number
      :refer [inc dec]]
    [hu.lib.object
      :refer [keys]]))

(defcurry ^boolean date-equal?
  [x y]
  (and (date? x)
       (date? y)
       (? (Number x) (Number y))))

(defcurry ^boolean pattern-equal?
  [x y]
  (and (pattern? x)
       (pattern? y)
       (? (.-source x) (.-source y))
       (? (.-global x) (.-global y))
       (? (.-multiline x) (.-multiline y))
       (? (.-ignoreCase x) (.-ignoreCase y))))

(def ^boolean reg-exp-equal? pattern-equal?)

(defcurry ^boolean array-equal?
  "Check if two arrays has the same elements"
  [x y]
  (and
    (array? x)
    (array? y)
    (identical? (.-length x) (.-length y))
    (loop [xs x
          ys y
          index 0
          count (.-length x)]
      (if (< index count)
        (if (equal? (get xs index) (get ys index))
            (recur xs ys (inc index) count)
            false)
      true))))

(defcurry ^boolean object-equal?
  "Check if two objects has the same
  value types on its properties"
  [x y]
  (and (object? x)
       (object? y)
       (let [x-keys (keys x)
             y-keys (keys y)
             x-count (.-length x-keys)
             y-count (.-length y-keys)]
         (and (? x-count y-count)
              (loop [index 0
                     count x-count
                     keys x-keys]
                (if (< index count)
                  (if (equal? (get x (get keys index))
                                   (get y (get keys index)))
                    (recur (inc index) count keys)
                    false)
                  true))))))

(defn ^boolean equal?
  "Returns true if x equals y, false if not. Compares
  numbers and collections in a type-independent manner.
  Clojure's immutable data structures define -equiv (and thus =)
  as a value, not an identity, comparison."
  ([x] true)
  ([x y] (or (? x y)
             (cond (null? x) (null? y)
                   (undef? y) (undef? x)
                   (string? x) (and (string? y) (? x y))
                   (number? x) (and (number? y) (? x y))
                   (fn? x) false
                   (bool? x) false
                   (date? x) (date-equal? x y)
                   (array? x) (array-equal? x y [] [])
                   (pattern? x) (pattern-equal? x y)
                   :else (object-equal? x y))))
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

(def ^boolean equal equal?)
(def ^boolean deep-equal? equal?)
(def ^boolean deep-equal equal?)
