(ns hu.lib.function
  (:require
    [hu.lib.common :refer [array?]]))

(defn ^:fn constant
  [x] (fn [] x))

(defn ^:mixed apply
  [f args] (.apply f nil args))

(defn ^:fn bind
  [f ctx] (.bind f ctx))
