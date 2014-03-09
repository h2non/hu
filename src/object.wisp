(ns hu.src.object)

(def ^:private has
  (.-has-own-property (.-prototype Object)))

(defn has 
  [obj prop] ((.-call has) obj, x))
