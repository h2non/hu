
(defmacro str
  [x expr]
  `(if (string? x) ~expr x))

(defmacro arr
  [x expr]
  `(if (array? x) ~expr x))
