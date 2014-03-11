(ns hu.lib.string
  (:require
    [hu.lib.common :refer [string?]]))

(def ^:private EOL #"[\n|\r]")

(defmacro str
  [x call]
  `(if (string? x) ~call x))

(defn ^string lines
  [x] (str x (.split x EOL)))

(defn ^string unlines
  [x] (str x (.join x EOL)))

(defn ^string words
  [x] (str x (.split x #"[ ]+")))

(defn ^string unwords
  [x] (str x (.join x " ")))

(defn ^string chars
  [x] (str x (.split x "")))

(defn ^string unchars
  [x] (str x (.join x "")))

(defn ^string subs
 [x start end]
 (str x (.substring x start end)))

(defn ^string reverse
  [x]
  (str x
    (.join
      (.reverse
        (.split x "")) "")))

(defn ^string repeat
  [n x]
  (if (> n 0)
    (+ x (repeat (- n 1) x)) ""))
