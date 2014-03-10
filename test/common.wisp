(ns hu.test.common
  (:require
    [hu.src.common :as common]
    [hu.test.util :refer [is thrown?]]))

(is (= "" (.is-string common nil) false))
