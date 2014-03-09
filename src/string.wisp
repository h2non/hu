(ns hu.src.string)

(defn lines 
  [x] (if x (.split x "\n") x))

(defn unlines 
  [x] (.join x "\n"))