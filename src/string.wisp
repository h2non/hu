(ns hu.lib.string
  (:require
    [hu.lib.common :refer [string? array? number?]]
    [hu.lib.object :refer [keys]]))

(def ^:private EOL #"[\n|\r]")

(defn ^string lines
  [x] (str x (.split x EOL)))

(defn ^string unlines
  [x] (arr x (.join x "\n")))

(defn ^string words
  [x] (str x (.split x #"[ ]+")))

(defn ^string unwords
  [x] (arr x (.join x " ")))

(defn ^string chars
  [x] (str x (.split x "")))

(defn ^string unchars
  [x] (arr x (.join x "")))

(defn ^string char
  [x]
  (cond (number? x)
    (.from-char-code String x)))

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
  (str x
    (if (> n 0)
      (+ x (repeat (- n 1) x)) "")))

(def ^:private html-escapes
 { :&   "&amp;"
   :<   "&lt;"
   :>   "&gt;"
   "\"" "&quot;"
   "'"  "&#39;" })

(def ^:private unescaped-html
  (RegExp. (+ "[" (.join (keys html-escapes)) "]") :g))

(defn- ^string escape-char
  [x] (aget html-escapes x))

(defn ^string escape
  [x]
  (if (string? x)
    (.replace (String x) unescaped-html escape-char) ""))
