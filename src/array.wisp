(ns hu.lib.array)

(defcurry ^boolean in-array
  "Checks if an element exists in the given array"
  [arr element]
  (>= (.index-of arr element) 0))
