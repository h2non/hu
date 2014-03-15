(ns hu.lib.function
  (:require
    [hu.lib.common :refer [array? fn?]]))

(def ^:private bind-fn
  (.-bind (.-prototype Function)))

(defn ^fn constant
  [x] (fn [] x))

(defn ^mixed apply
  [f args] (.apply f nil args))

(defn ^fn bind
  [f ctx] (.call bind-fn f ctx))

(defn ^fn partial
  [f & args]
  (fn [& pargs]
    (apply f (.concat args pargs))))

(defn ^fn curry
  [f & args]
  (def ^fn **curry
    (fn [cargs]
      (if (> (.-length f) 1)
        (let [params (or cargs args)]
        (fn []
          (if (and
            (< (params.push.apply params arguments) (.-length f))
            (.-length arguments))
              (**curry params)
              (apply f params)))) f))) (**curry))

(defn ^fn compose
  [f & funcs]
  (fn [& args]
    (let [val (apply f args)]
      (.reduce funcs
        (fn [acc f]
          (cond (and acc (fn? f)) (set! val (f acc)))) val) val)))

(defn ^mixed wrap
  [f to & args]
  (fn [& cargs]
    (apply to (.concat [f] args cargs))))

(defn ^void delay
  [f ms & args]
  (set-timeout
    (fn [] (apply f args)) (or ms 1000)))

(defn ^void defer
  [& args]
  (fn [& cargs] (apply delay (.concat args cargs))))
