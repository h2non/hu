(ns hu.lib.function)

(def ^:private bind-fn
  (.-bind (.-prototype Function)))

(defn ^fn constant
  "Creates a function that returns value"
  [x] (fn [] x))

(def ^fn identify constant)

(defn ^fn lazy 
  [lambda default-result]
  (fn [task & args]
    (let [result (apply task args)]
      (when result  
        (apply lambda (.concat args [result])) 
        (apply lambda (.concat args [default-result]))))))

(defn ^mixed apply
  "Invokes a function without binding a context
  with the given arguments as array"
  [lambda args] (.apply lambda lambda args))

(defn ^fn bind
  "Creates a function that, when called, invokes the function
  with the this binding of thisArg and prepends any additional
  bind arguments to those provided to the bound function"
  [lambda ctx] (.call bind-fn lambda ctx))

(defn ^fn partial
  "Creates a function that, when called, invokes
  func with any additional partial arguments
  prepended to those provided to the new function"
  [lambda & args]
  (fn [& pargs]
    (apply lambda (.concat args pargs))))

(defn ^:private ^fn currier
  "Function either continues curring of the arguments
  or executes function if desired arguments have being collected.
  If function curried is variadic then execution without arguments
  will finish curring and trigger the function"
  [lambda arity params]
  (fn ^fn curried
    [& args]
    (let [run (and (? Infinity arity) (? (.-length args) 0))]
      (when params (.apply (.-unshift args) args params))
      (when (or (>= (.-length args) arity) run)
        (apply lambda args)
        (currier lambda arity args)))))

(defn ^fn curry
  "Creates a function which accepts one or more
  arguments of the given function that when invoked either
  executes the function returning its result"
  [lambda & args]
  (let [iargs (.-length lambda)
        cargs (.-length args)
        arity (when cargs (- iargs cargs))]
    (currier lambda (or arity iargs) args)))

(defn ^fn compose
  "Creates a function that is the composition of the
  provided functions, where each function consumes
  the return value of the function that follows"
  [lambda & funcs]
  (fn [& args]
    (let [val (apply lambda args)]
      (.reduce funcs
        (fn [acc lambda]
          (cond (and acc lambda)
            (set! val (lambda acc)))) val) val)))

(defn ^fn memoize
  "Creates a function that memoizes the result
  of the the given function. If resolver is provided
  it will be used to determine the cache key for
  storing the result based on the arguments provided
  to the memoized function.
  The resolver function just uses the first argument
  to the memoized function as the key"
  [lambda resolver]
  (let [memo {}]
    (fn [& args]
      (let [key (+ :@ (when resolver
                        (apply resolver args)
                        (aget args 0)))]
        (when (.has-own-property memo key)
          (aget memo key)
          (set! (aget memo key) (apply lambda args)))))))

(defn ^mixed wrap
  "Creates a function that provides value to the wrapper
  function as its first argument. Additional arguments
  provided to the function are appended to those provided
  to the wrapper function"
  [lambda to & args]
  (fn [& cargs]
    (apply to (.concat [lambda] args cargs))))

(defn ^mixed once
  "Creates a function that is restricted to execute function
  once time. Subsuquents calls to the function will return
  the memoized value of the initial call"
  [lambda]
  (let [call true
        memoized nil]
    (fn [& args]
      (when call
        (do
          (set! call false)
          (set! memoized (apply lambda args))) memoized))))

(defcurry ^mixed times
  "Creates a function that is restricted to be executed
  a finite number of times. Subsuquents calls to the
  function will return the memoized value of the latest call"
  [lambda n]
  (let [c 0
        n (or n 1)
        memoized nil]
    (fn [& args]
      (when (< c n)
        (do
          (set! c (+ c 1))
          (when (not? c n)
            (apply lambda args)
            (set! memoized (apply lambda args)))) memoized))))

(defcurry ^fn throttle
  "Creates a function that, when executed, will only call the fn
  function at most once per every wait milliseconds"
  [fn ms]
  (let [t 0
        ms (or ms 100)]
    (fn [& args]
      (cond (or (identical? t 0) (> (- (.now Date) t) ms))
        (let []
          (set! t (.now Date))
          (apply fn args) nil)))))

(defn ^void defer
  "Executes the given function after wait milliseconds.
  You can provide arguments that will be passed to the
  function when it's invoked"
  [lambda ms & args]
  (set-timeout
    (fn []
      (apply lambda args)) (or ms 1000)))

(defn ^void debounce
  "Return a function that executes the given function after wait
  milliseconds when it's called. You can provide arguments
  that will be passed to the function when it will be invoked"
  [& args]
  (fn [& cargs]
    (apply defer (.concat args cargs))))
