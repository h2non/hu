(ns hu.lib.function)

(def ^:private bind-fn
  (.-bind (.-prototype Function)))

(defn ^fn constant
  "Creates a function that returns value"
  [x] (fn [] x))

(def ^fn identify constant)

(defn ^mixed apply
  "Invokes a function without binding a context
  with the given arguments as array"
  [f args] (.apply f f args))

(defn ^fn bind
  "Creates a function that, when called, invokes the function
  with the this binding of thisArg and prepends any additional
  bind arguments to those provided to the bound function"
  [f ctx] (.call bind-fn f ctx))

(defn ^fn partial
  "Creates a function that, when called, invokes
  func with any additional partial arguments
  prepended to those provided to the new function"
  [f & args]
  (fn [& pargs]
    (apply f (.concat args pargs))))

(defn ^fn curry
  "Creates a function which accepts one or more
  arguments of the given function that when invoked either
  executes the function returning its result"
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
  "Creates a function that is the composition of the
  provided functions, where each function consumes
  the return value of the function that follows"
  [f & funcs]
  (fn [& args]
    (let [val (apply f args)]
      (.reduce funcs
        (fn [acc f]
          (cond (and acc f)
            (set! val (f acc)))) val) val)))

(defn ^mixed wrap
  "Creates a function that provides value to the wrapper
  function as its first argument. Additional arguments
  provided to the function are appended to those provided
  to the wrapper function"
  [f to & args]
  (fn [& cargs]
    (apply to (.concat [f] args cargs))))

(defn ^mixed once
  "Creates a function that is restricted to execute function
  once time. Subsuquents calls to the function will return
  the memoized value of the initial call"
  [f]
  (let [call true
        memoized nil]
    (fn [& args]
      (when call
        (do
          (set! call false)
          (set! memoized (apply f args))) memoized))))

(defn ^mixed times
  "Creates a function that is restricted to be executed
  a finite number of times. Subsuquents calls to the
  function will return the memoized value of the latest call"
  [f n]
  (let [c 0
        n (or n 1)
        memoized nil]
    (fn [& args]
      (when (< c n)
        (do
          (set! c (+ c 1))
          (when (not? c n)
            (apply f args)
            (set! memoized (apply f args)))) memoized))))

(defn ^void defer
  "Executes the given function after wait milliseconds.
  You can provide arguments that will be passed to the
  function when it's invoked"
  [f ms & args]
  (set-timeout
    (fn []
      (apply f args)) (or ms 1000)))

(defn ^void debounce
  "Return a function that executes the given function after wait
  milliseconds when it's called. You can provide arguments
  that will be passed to the function when it will be invoked"
  [& args]
  (fn [& cargs]
    (apply defer (.concat args cargs))))
