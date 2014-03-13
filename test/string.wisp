(ns hu.test.string
  (:require
    [assert :refer [equal deep-equal]]
    [hu.lib.string :as _]))

(suite :lines
  (fn []
    (test :invalid
      (fn []
        (equal (.lines _ nil) nil)
        (equal (.lines _ 100) 100)
        (deep-equal (.lines _ [1]) [1])))
    (test :valid
      (fn []
        (equal (.-length (.lines _ "line\nanother")) 2)
        (equal (.-length (.lines _ "line\ran\nother")) 3)))))

(suite :unlines
  (fn []
    (test :invalid
      (fn []
        (equal (.unlines _ nil) nil)
        (equal (.unlines _ 100) 100)
        (deep-equal (.unlines _ {:a 1}) {:a 1})))
    (test :valid
      (fn []
        (equal (.-length (.unlines _ ["line"])) 4)
        (equal (.-length (.unlines _ ["line" "another"])) 12)))))

(suite :words
  (fn []
    (test :invalid
      (fn []
        (equal (.words _ nil) nil)
        (equal (.words _ 100) 100)
        (deep-equal (.words _ {:a 1}) {:a 1})))
    (test :valid
      (fn []
        (equal (.-length (.words _ "word")) 1)
        (equal (.-length (.words _ "some word")) 2)
        (equal (.-length (.words _ "some another \\sword")) 3)))))

(suite :unwords
  (fn []
    (test :invalid
      (fn []
        (equal (.unwords _ nil) nil)
        (equal (.unwords _ 100) 100)
        (deep-equal (.unwords _ {:a 1}) {:a 1})))
    (test :valid
      (fn []
        (equal (.-length (.unwords _ ["word"])) 4)
        (equal (.-length (.unwords _ ["some" "word"])) 9)
        (equal (.-length (.unwords _ ["some" " another" "word"])) 18)))))

(suite :chars
  (fn []
    (test :invalid
      (fn []
        (equal (.chars _ nil) nil)
        (equal (.chars _ 100) 100)
        (deep-equal (.chars _ {:a 1}) {:a 1})))
    (test :valid
      (fn []
        (equal (.-length (.chars _ "word")) 4)
        (equal (.-length (.chars _ "some word")) 9)
        (equal (.-length (.chars _ "some another word")) 17)))))

(suite :subs
  (fn []
    (test :invalid
      (fn []
        (equal (.subs _ nil) nil)
        (equal (.subs _ 100) 100)
        (deep-equal (.subs _ {:a 1}) {:a 1})))
    (test :valid
      (fn []
        (equal (.subs _ "word" 2 4) "rd")
        (equal (.subs _ "some word" 5 6) "w")))))

(suite :char
  (fn []
    (test :invalid
      (fn []
        (equal (.char _ nil) nil)
        (equal (.char _ false) nil)))
    (test :valid
      (fn []
        (equal (.char _ 19) "\u0013")
        (equal (.char _ 124) "|")))))

(suite :reverse
  (fn []
    (test :invalid
      (fn []
        (equal (.reverse _ nil) nil)
        (equal (.reverse _ 100) 100)
        (deep-equal (.reverse _ {:a 1}) {:a 1})))
    (test :valid
      (fn []
        (equal (.reverse _ "word") "drow")
        (equal (.reverse _ "another") "rehtona")))))

(suite :repeat
  (fn []
    (test :invalid
      (fn []
        (equal (.repeat _ nil) nil)
        (equal (.repeat _ 10) undefined)
        (deep-equal (.repeat _ 10 {:a 1}) {:a 1})))
    (test :valid
      (fn []
        (equal (.repeat _ 2 "o") "oo")
        (equal (.repeat _ 10 "o") "oooooooooo")))))

(suite :escape
  (fn []
    (test :invalid
      (fn []
        (equal (.escape _ nil) "")
        (equal (.escape _ 10) "")
        (equal (.escape _ true) "")
        (deep-equal (.escape _ {:a 1}) "")))
    (test :valid
      (fn []
        (equal (.escape _ "<a>") "&lt;a&gt;")
        (equal (.escape _ "x&y") "x&amp;y")))))
