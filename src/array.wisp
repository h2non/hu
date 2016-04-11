(ns hu.lib.array
  (:require
    [hu.lib.type :refer [array?]]))

(defcurry ^boolean in-array
  "Checks if an element exists in the given array"
  [arr element]
  (>= (.index-of arr element) 0))

(defn ^mixed head
  "First item of the given array"
  [arr]
  (arr? arr (aget arr 0)))

(def ^array first head)

(defn ^array tail
  "Everything but the first item of the list"
  [arr]
  (arr? arr (.slice arr 1)))

(def ^array rest tail)

(defn ^mixed last
  "Return last item of the list"
  [arr]
  (arr? arr (.slice arr -1)))

(def ^mixed end last)

(defn ^boolean initial
  "Everything but the last item of the list"
  [arr]
  (arr? arr (.slice arr 0, -1)))

(defn ^array flatten
  "Recursively flatten elements of a multidimensional list
  into a one dimension list. Uses accumulator strategy and function overloading."
  ([] [])
  ([arr] (flatten arr []))
  ([arr acc]
    (if (array? arr)
      (.for-each arr (fn [el] (flatten el acc)))
      (if (def? arr) (.push acc arr))) acc))
