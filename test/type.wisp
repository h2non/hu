(ns hu.test.type
  (:require
    [assert :refer [equal]]
    [hu.lib.type :as _]))

(suite :isNull
  (fn []
    (test :invalid
      (fn []
        (equal (.null? _ :str) false)
        (equal (.null? _ 12) false)
        (equal (.null? _ NaN) false)
        (equal (.null? _ 0) false)
        (equal (.null? _ [1]) false)
        (equal (.null? _ "") false)
        (equal (.null? _ 0) false)
        (equal (.null? _ nil) false)
        (equal (.null? _ undefined) false)
        (equal (.null? _ {:a 1}) false)))
    (test :valid
      (fn []
        (equal (.null? _ null) true)))))

(suite :isUndef
  (fn []
    (test :invalid
      (fn []
        (equal (.undef? _ :str) false)
        (equal (.undef? _ 12) false)
        (equal (.undef? _ NaN) false)
        (equal (.undef? _ 0) false)
        (equal (.undef? _ [1]) false)
        (equal (.undef? _ "") false)
        (equal (.undef? _ 0) false)
        (equal (.undef? _ {:a 1}) false)))
    (test :valid
      (fn []
        (equal (.undef? _ nil) true)
        (equal (.undef? _ null) true)
        (equal (.undef? _ undefined) true)))))

(suite :isEmpty
  (fn []
    (test :invalid
      (fn []
        (equal (.empty? _ :str) false)
        (equal (.empty? _ 12) false)
        (equal (.empty? _ NaN) false)
        (equal (.empty? _ 0) false)
        (equal (.empty? _ [1]) false)
        (equal (.empty? _ {:a 1}) false)))
    (test :valid
      (fn []
        (equal (.empty? _ nil) true)
        (equal (.empty? _ null) true)
        (equal (.empty? _ undefined) true)
        (equal (.empty? _ "") true)
        (equal (.empty? _ []) true)
        (equal (.empty? _ {}) true)))))

(suite :nonEmpty
  (fn []
    (test :invalid
      (fn []
        (equal (.not-empty _ nil) false)
        (equal (.not-empty _ null) false)
        (equal (.not-empty _ undefined) false)
        (equal (.not-empty _ "") false)
        (equal (.not-empty _ []) false)
        (equal (.not-empty _ {}) false)))
    (test :valid
      (fn []
        (equal (.not-empty _ :str) true)
        (equal (.not-empty _ 12) true)
        (equal (.not-empty _ NaN) true)
        (equal (.not-empty _ 0) true)
        (equal (.not-empty _ [1]) true)
        (equal (.not-empty _ {:a 1}) true)))))

(suite :isBool
  (fn []
    (test :invalid
      (fn []
        (equal (.bool? _ :str) false)
        (equal (.bool? _ nil) false)
        (equal (.bool? _ undefined) false)
        (equal (.bool? _ 12) false)
        (equal (.bool? _ null) false)
        (equal (.bool? _ {}) false)
        (equal (.bool? _ []) false)))
    (test :valid
      (fn []
        (equal (.bool? _ true) true)
        (equal (.bool? _ false) true)
        (equal (.bool? _ (Boolean :str)) true)
        (equal (.bool? _ (Boolean.)) true)))))

(suite :isNumber
  (fn []
    (test :invalid
      (fn []
        (equal (.number? _ :str) false)
        (equal (.number? _ nil) false)
        (equal (.number? _ undefined) false)
        (equal (.number? _ true) false)
        (equal (.number? _ null) false)
        (equal (.number? _ {}) false)
        (equal (.number? _ []) false)))
    (test :valid
      (fn []
        (equal (.number? _ 12) true)
        (equal (.number? _ 12.3) true)
        (equal (.number? _ NaN) true)
        (equal (.number? _ (Number :str)) true)
        (equal (.number? _ (Number.)) true)))))

(suite :isFinite
  (fn []
    (test :invalid
      (fn []
        (equal (.finite? _ Infinity) false)
        (equal (.finite? _ "zero") false)
        (equal (.finite? _ NaN) false)))
    (test :valid
      (fn []
        (equal (.finite? _ 1) true)
        (equal (.finite? _ 0) true)
        (equal (.finite? _ []) true)
        (equal (.finite? _ (Number 1)) true)
        (equal (.finite? _ (Number.)) true)))))

(suite :isNaN
  (fn []
    (test :basic
      (fn []
        (equal (.NaN? _ 1) false)
        (equal (.NaN? _ -1) false)
        (equal (.NaN? _ 3.14) false)
        (equal (.NaN? _ Infinity) false)
        (equal (.NaN? _ NaN) true)
        (equal (.NaN? _ nil) false)))))

(suite :isSymbol
  (fn []
    (test :invalid
      (fn []
        (equal (.symbol? _ Infinity) false)
        (equal (.symbol? _ "zero") false)
        (equal (.symbol? _ nil) false)
        (equal (.symbol? _ []) false)))
    (test :valid
      (fn []
        ; not supported in node
        (cond (.-browser? _)
          (equal (.symbol? _ (Symbol.)) true))))))

(suite :isString
  (fn []
    (test :invalid
      (fn []
        (equal (.string? _ 12) false)
        (equal (.string? _ nil) false)
        (equal (.string? _ undefined) false)
        (equal (.string? _ true) false)
        (equal (.string? _ null) false)
        (equal (.string? _ {}) false)
        (equal (.string? _ []) false)))
    (test :valid
      (fn []
        (equal (.string? _ "") true)
        (equal (.string? _ :str) true)
        (equal (.string? _ (String :str)) true)
        (equal (.string? _ (String.)) true)))))

(suite :isDate
  (fn []
    (test :invalid
      (fn []
        (equal (.date? _ 12) false)
        (equal (.date? _ nil) false)
        (equal (.date? _ undefined) false)
        (equal (.date? _ true) false)
        (equal (.date? _ null) false)
        (equal (.date? _ {}) false)
        (equal (.date? _ []) false)
        (equal (.date? _ "") false)))
    (test :valid
      (fn []
        (equal (.date? _ (Date.)) true)
        (equal (.date? _ (Date. 1)) true)))))

(suite :isRegExp
  (fn []
    (test :invalid
      (fn []
        (equal (.reg-exp? _ 12) false)
        (equal (.reg-exp? _ nil) false)
        (equal (.reg-exp? _ undefined) false)
        (equal (.reg-exp? _ true) false)
        (equal (.reg-exp? _ null) false)
        (equal (.reg-exp? _ {}) false)
        (equal (.reg-exp? _ []) false)
        (equal (.reg-exp? _ "") false)))
    (test :valid
      (fn []
        (equal (.reg-exp? _ #"[a-z]") true)
        (equal (.reg-exp? _ (RegExp.)) true)))))

(suite :isArgs
  (fn []
    (test :invalid
      (fn []
        (equal (.args? _ 12) false)
        (equal (.args? _ nil) false)
        (equal (.args? _ undefined) false)
        (equal (.args? _ true) false)
        (equal (.args? _ null) false)
        (equal (.args? _ {}) false)
        (equal (.args? _ []) false)
        (equal (.args? _ "") false)))
    (test :valid
      (fn []
        (equal (.args? _ arguments) true)))))

(suite :isArray
  (fn []
    (test :invalid
      (fn []
        (equal (.array? _ :str) false)
        (equal (.array? _ nil) false)
        (equal (.array? _ undefined) false)
        (equal (.array? _ 12) false)
        (equal (.array? _ null) false)
        (equal (.array? _ NaN) false)
        (equal (.array? _ {}) false)))
    (test :valid
      (fn []
        (equal (.array? _ []) true)
        (equal (.array? _ (Array 1)) true)
        (equal (.array? _ (Array.)) true)))))

(suite :isObject
  (fn []
    (test :invalid
      (fn []
        (equal (.object? _ :str) false)
        (equal (.object? _ nil) false)
        (equal (.object? _ undefined) false)
        (equal (.object? _ 12) false)
        (equal (.object? _ null) false)
        (equal (.object? _ NaN) false)
        (equal (.object? _ []) false)))
    (test :valid
      (fn []
        (equal (.object? _ {}) true)
        (equal (.object? _ (Object.)) true)
        (equal (.object? _ (.create Object (.-prototype Object))) true)))))

(suite :isPlainObject
  (fn []
    (test :invalid
      (fn []
        (equal (.plain-object? _ :str) false)
        (equal (.plain-object? _ nil) false)
        (equal (.plain-object? _ undefined) false)
        (equal (.plain-object? _ 12) false)
        (equal (.plain-object? _ null) false)
        (equal (.plain-object? _ NaN) false)
        (equal (.plain-object? _ []) false)
        (equal (.plain-object? _ (Function.)) false)
        (equal (.plain-object? _ (.-prototype String)) false)))
    (test :valid
      (fn []
        (equal (.plain-object? _ {}) true)
        (equal (.plain-object? _ (Object.)) true)
        (equal (.plain-object? _ (.create Object (.-prototype Object))) true)))))

(suite :isFunction
  (fn []
    (test :invalid
      (fn []
        (equal (.function? _ :str) false)
        (equal (.function? _ nil) false)
        (equal (.function? _ undefined) false)
        (equal (.function? _ 12) false)
        (equal (.function? _ null) false)
        (equal (.function? _ NaN) false)
        (equal (.function? _ []) false)
        (equal (.function? _ {}) false)))
    (test :valid
      (fn []
        (equal (.function? _ (fn [])) true)
        (equal (.function? _ Function) true)
        (equal (.function? _ (Function.)) true)))))

(suite :isError
  (fn []
    (test :invalid
      (fn []
        (equal (.error? _ 12) false)
        (equal (.error? _ nil) false)
        (equal (.error? _ undefined) false)
        (equal (.error? _ true) false)
        (equal (.error? _ null) false)
        (equal (.error? _ {}) false)
        (equal (.error? _ []) false)
        (equal (.error? _ "") false)))
    (test :valid
      (fn []
        (equal (.error? _ (Error.)) true)
        (equal (.error? _ (Error. :ups)) true)))))

(suite :isElement
  (fn []
    (test :invalid
      (fn []
        (equal (.element? _ :str) false)
        (equal (.element? _ 12) false)
        (equal (.element? _ NaN) false)
        (equal (.element? _ nil) false)
        (equal (.element? _ null) false)
        (equal (.element? _ false) false)))
    (test :valid
      (fn []
        (cond (.-browser? _)
          (equal (.element? _ (.create-element document :div)) true))))))

(suite :isMutable
  (fn []
    (test :invalid
      (fn []
        (equal (.mutable? _ :str) false)
        (equal (.mutable? _ 12) false)
        (equal (.mutable? _ NaN) false)
        (equal (.mutable? _ nil) false)
        (equal (.mutable? _ null) false)
        (equal (.mutable? _ false) false)))
    (test :valid
      (fn []
        (equal (.mutable? _ {}) true)
        (equal (.mutable? _ []) true)
        (equal (.mutable? _ (Date.)) true)))))

(suite :isPrimitive
  (fn []
    (test :invalid
      (fn []
        (equal (.primitive? _ {}) false)
        (equal (.primitive? _ []) false)
        (equal (.primitive? _ (Date.)) false)))
    (test :valid
      (fn []
        (equal (.primitive? _ :str) true)
        (equal (.primitive? _ 12) true)
        (equal (.primitive? _ NaN) true)
        (equal (.primitive? _ #"[a-z]") true)
        (equal (.primitive? _ null) true)
        (equal (.primitive? _ true) true)))))

(suite :isIterable
  (fn []
    (test :invalid
      (fn []
        (equal (.mutable? _ :str) false)
        (equal (.mutable? _ 12) false)
        (equal (.mutable? _ NaN) false)
        (equal (.mutable? _ nil) false)
        (equal (.mutable? _ null) false)
        (equal (.mutable? _ false) false)))
    (test :valid
      (fn []
        (equal (.mutable? _ {}) true)
        (equal (.mutable? _ []) true)
        (equal (.mutable? _ arguments) true)))))
