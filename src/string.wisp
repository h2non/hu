(ns hu.lib.string
  (:require
    [hu.lib.type :refer [string? array? number?]]
    [hu.lib.object :refer [keys]]))

(def ^:private EOL #"[\n|\r]")

(defn ^string subs
  "Extract characters from the given string"
  [x start end]
  (str x (.substring x start end)))

(defn ^string lines
  "Split the given string by end of line tokens"
  [x] (str x (.split x EOL)))

(defn ^string unlines
  "Join the given array into a string separated by end line token"
  [x] (arr x (.join x "\n")))

(defn ^string words
  "Returns an array of words (spaces separated)"
  [x] (str x (.split x #"[ ]+")))

(defn ^string unwords
  "Join words of the given array into a string spaces separated"
  [x] (arr x (.join x " ")))

(defn ^string chars
  "Return an array of characters of the given string"
  [x] (str x (.split x "")))

(defn ^string unchars
  "Join the strings of the given array"
  [x] (arr x (.join x "")))

(defn ^string char
  "Return the given unicode number into his equivalent character"
  [x]
  (cond (number? x)
    (.from-char-code String x)))

(defn ^string reverse
  "Reverse characters of the given string"
  [x]
  (str x
    (.join
      (.reverse
        (.split x "")) "")))

(defn ^string repeat
  "Repeat the given string"
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

(defn ^:private ^string escape-char
  [x] (aget html-escapes x))

(defn ^string escape
  "Converts the characters &, <, >, \", and ' in the given string
  to their corresponding HTML entities"
  [x]
  (if (string? x)
    (.replace (String x) unescaped-html escape-char) ""))
