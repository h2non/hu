(ns hu.test.common
  (:require
    [assert :refer [equal deep-equal]]
    [hu.lib.common :as _]))

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

(suite :isNumber
  (fn []
    (test :invalid
      (fn []
        (equal (.number? _ :str) false)
        (equal (.number? _ nil) false)
        (equal (.number? _ undefined) false)
        (equal (.number? _ true) false)
        (equal (.number? _ null) false)
        (equal (.number? _ NaN) false)
        (equal (.number? _ {}) false)
        (equal (.number? _ []) false)))
    (test :valid
      (fn []
        (equal (.number? _ 12) true)
        (equal (.number? _ 12.3) true)
        (equal (.number? _ (Number :str)) true)
        (equal (.number? _ (Number.)) true)))))

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
        (equal (.object? _ String) true)
        (equal (.object? _ (Object :str)) true)
        (equal (.object? _ (Object.)) true)))))

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
        (equal (.array? _ []) false)))
    (test :valid
      (fn []
        (equal (.array? _ {}) true)
        (equal (.array? _ String) true)
        (equal (.array? _ (Array 1)) true)
        (equal (.array? _ (Array.)) true)))))

(suite :isEmpty
  (fn []
    (test :invalid
      (fn []
        (equal (.empty? _ :str) false)
        (equal (.empty? _ nil) false)
        (equal (.empty? _ undefined) false)
        (equal (.empty? _ 12) false)
        (equal (.empty? _ null) false)
        (equal (.empty? _ NaN) false)
        (equal (.empty? _ []) false)))
    (test :valid
      (fn []
        (equal (.empty? _ {}) true)
        (equal (.empty? _ String) true)
        (equal (.empty? _ (empty :str)) true)
        (equal (.empty? _ (Object.)) true)))))

