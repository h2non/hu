(ns hu.lib.array)

(defcurry ^boolean in-array
  "Checks if an element exists in the given array"
  [arr element]
  (>= (.index-of arr element) 0))

(defn ^array head
  "First item of the given array"
  [arr]
  (arr arr (aget arr 0)))

(def ^array first head)

(defn ^array tail
  "Everything but the first item of the list"
  [arr]
  (arr arr (.slice arr 1)))

(def ^array rest tail)

(defn ^boolean last
  "The last item of the list"
  [arr]
  (arr arr (.slice arr -1)))

(def ^array end last)

(defn ^boolean initial
  "Everything but the last item of the list"
  [arr]
  (arr arr (.slice arr 0, -1)))
