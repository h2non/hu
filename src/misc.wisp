(ns hu.lib.misc)

(def ^void noop (fn []))

(def ^number now (.-now Date))

(defn log
  "Log messages in console"
  [& args]
  (cond console
    (.apply (.-log console) console args)))

(def ^boolean browser?
  (do
    (and
      (? (typeof window) "object")
      (.-HTMLElement window))))

(def ^object *global (if browser? window global))
