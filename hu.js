/*! hu.js - v0.1.0 - MIT License - https://github.com/h2non/hu */
!function(e){if("object"==typeof exports)module.exports=e();else if("function"==typeof define&&define.amd)define(e);else{var f;"undefined"!=typeof window?f=window:"undefined"!=typeof global?f=global:"undefined"!=typeof self&&(f=self),f.hu=e()}}(function(){var define,module,exports;return (function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);throw new Error("Cannot find module '"+o+"'")}var f=n[o]={exports:{}};t[o][0].call(f.exports,function(e){var n=t[o][1][e];return s(n?n:e)},f,f.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(_dereq_,module,exports){
{
    var _ns_ = {
            id: 'hu.lib.macros',
            doc: void 0
        };
    var hu_lib_function = _dereq_('./function');
    var curry = hu_lib_function.curry;
    var compose = hu_lib_function.compose;
    var hu_lib_type = _dereq_('./type');
    var isString = hu_lib_type.isString;
    var isArray = hu_lib_type.isArray;
    var isObject = hu_lib_type.isObject;
}
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
{
    var _ns_ = {
            id: 'hu.lib.array',
            doc: void 0
        };
}
var inArray = exports.inArray = function inArray() {
        var args = Array.prototype.slice.call(arguments, 0);
        return curry(function (arr, element) {
            return arr.indexOf(element) >= 0;
        }).apply(void 0, args);
    };
var head = exports.head = function head(arr) {
        return isArray(arr) ? arr[0] : arr;
    };
var first = exports.first = head;
var tail = exports.tail = function tail(arr) {
        return isArray(arr) ? arr.slice(1) : arr;
    };
var rest = exports.rest = tail;
var last = exports.last = function last(arr) {
        return isArray(arr) ? arr.slice(-1) : arr;
    };
var end = exports.end = last;
var initial = exports.initial = function initial(arr) {
        return isArray(arr) ? arr.slice(0, -1) : arr;
    };
},{"./function":4,"./type":10}],2:[function(_dereq_,module,exports){
{
    var _ns_ = {
            id: 'hu.lib.macros',
            doc: void 0
        };
    var hu_lib_function = _dereq_('./function');
    var curry = hu_lib_function.curry;
    var compose = hu_lib_function.compose;
    var hu_lib_type = _dereq_('./type');
    var isString = hu_lib_type.isString;
    var isArray = hu_lib_type.isArray;
    var isObject = hu_lib_type.isObject;
}
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
{
    var _ns_ = {
            id: 'hu.lib.collection',
            doc: void 0
        };
    var hu_lib_type = _dereq_('./type');
    var isObject = hu_lib_type.isObject;
    var isArray = hu_lib_type.isArray;
    var isEmpty = hu_lib_type.isEmpty;
    var isIterable = hu_lib_type.isIterable;
    var isNotEmpty = hu_lib_type.isNotEmpty;
    var hu_lib_object = _dereq_('./object');
    var keys = hu_lib_object.keys;
    var filter = hu_lib_object.filter;
}
var each = exports.each = function each() {
        var args = Array.prototype.slice.call(arguments, 0);
        return curry(function (clt, cb) {
            isIterable(clt) ? keys(clt).forEach(function (index) {
                return cb(clt[index], index, clt);
            }) : void 0;
            return clt;
        }).apply(void 0, args);
    };
var forEach = exports.forEach = each;
var size = exports.size = function size(clt) {
        return isIterable(clt) ? isObject(clt) ? keys(clt).length : clt.length : 0;
    };
var compact = exports.compact = function compact(clt) {
        return isArray(clt) ? clt.filter(isNotEmpty) : filter(clt, isNotEmpty);
    };
var clean = exports.clean = compact;
},{"./function":4,"./object":8,"./type":10}],3:[function(_dereq_,module,exports){
{
    var _ns_ = {
            id: 'hu.lib.macros',
            doc: void 0
        };
    var hu_lib_function = _dereq_('./function');
    var curry = hu_lib_function.curry;
    var compose = hu_lib_function.compose;
    var hu_lib_type = _dereq_('./type');
    var isString = hu_lib_type.isString;
    var isArray = hu_lib_type.isArray;
    var isObject = hu_lib_type.isObject;
}
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
{
    var _ns_ = {
            id: 'hu.lib.equality',
            doc: void 0
        };
    var hu_lib_type = _dereq_('./type');
    var isDate = hu_lib_type.isDate;
    var isArray = hu_lib_type.isArray;
    var isObject = hu_lib_type.isObject;
    var isFn = hu_lib_type.isFn;
    var isNull = hu_lib_type.isNull;
    var isUndef = hu_lib_type.isUndef;
    var isString = hu_lib_type.isString;
    var isNumber = hu_lib_type.isNumber;
    var isBool = hu_lib_type.isBool;
    var isIterable = hu_lib_type.isIterable;
    var isPattern = hu_lib_type.isPattern;
    var isPatternEqual = hu_lib_type.isPatternEqual;
    var isDateEqual = hu_lib_type.isDateEqual;
    var hu_lib_number = _dereq_('./number');
    var inc = hu_lib_number.inc;
    var dec = hu_lib_number.dec;
    var hu_lib_object = _dereq_('./object');
    var keys = hu_lib_object.keys;
}
var isDateEqual = exports.isDateEqual = function isDateEqual() {
        var args = Array.prototype.slice.call(arguments, 0);
        return curry(function (x, y) {
            return isDate(x) && isDate(y) && Number(x) === Number(y);
        }).apply(void 0, args);
    };
var dateEqual = exports.dateEqual = isDateEqual;
var isPatternEqual = exports.isPatternEqual = function isPatternEqual() {
        var args = Array.prototype.slice.call(arguments, 0);
        return curry(function (x, y) {
            return isPattern(x) && isPattern(y) && x.source === y.source && x.global === y.global && x.multiline === y.multiline && x.ignoreCase === y.ignoreCase;
        }).apply(void 0, args);
    };
var isRegExpEqual = exports.isRegExpEqual = isPatternEqual;
var patternEqual = exports.patternEqual = isPatternEqual;
var isArrayEqual = exports.isArrayEqual = function isArrayEqual() {
        var args = Array.prototype.slice.call(arguments, 0);
        return curry(function (x, y) {
            return isArray(x) && isArray(y) && x.length === y.length && function loop() {
                var recur = loop;
                var xsø1 = x;
                var ysø1 = y;
                var indexø1 = 0;
                var countø1 = x.length;
                do {
                    recur = indexø1 < countø1 ? isEqual((xsø1 || 0)[indexø1], (ysø1 || 0)[indexø1]) ? (loop[0] = xsø1, loop[1] = ysø1, loop[2] = inc(indexø1), loop[3] = countø1, loop) : false : true;
                } while (xsø1 = loop[0], ysø1 = loop[1], indexø1 = loop[2], countø1 = loop[3], recur === loop);
                return recur;
            }.call(this);
        }).apply(void 0, args);
    };
var arrayEqual = exports.arrayEqual = isArrayEqual;
var isObjectEqual = exports.isObjectEqual = function isObjectEqual() {
        var args = Array.prototype.slice.call(arguments, 0);
        return curry(function (x, y) {
            return isObject(x) && isObject(y) && function () {
                var xKeysø1 = keys(x);
                var yKeysø1 = keys(y);
                var xCountø1 = xKeysø1.length;
                var yCountø1 = yKeysø1.length;
                return xCountø1 === yCountø1 && function loop() {
                    var recur = loop;
                    var indexø1 = 0;
                    var countø1 = xCountø1;
                    var keysø1 = xKeysø1;
                    do {
                        recur = indexø1 < countø1 ? isEqual((x || 0)[(keysø1 || 0)[indexø1]], (y || 0)[(keysø1 || 0)[indexø1]]) ? (loop[0] = inc(indexø1), loop[1] = countø1, loop[2] = keysø1, loop) : false : true;
                    } while (indexø1 = loop[0], countø1 = loop[1], keysø1 = loop[2], recur === loop);
                    return recur;
                }.call(this);
            }.call(this);
        }).apply(void 0, args);
    };
var objectEqual = exports.objectEqual = isObjectEqual;
var isEqual = exports.isEqual = function isEqual() {
        switch (arguments.length) {
        case 1:
            var x = arguments[0];
            return true;
        case 2:
            var x = arguments[0];
            var y = arguments[1];
            return x === y || (isNull(x) ? isNull(y) : isUndef(y) ? isUndef(x) : isString(x) ? isString(y) && x === y : isNumber(x) ? isNumber(y) && x === y : isFn(x) ? false : isBool(x) ? false : isDate(x) ? isDateEqual(x, y) : isArray(x) ? isArrayEqual(x, y, [], []) : isPattern(x) ? isPatternEqual(x, y) : 'else' ? isObjectEqual(x, y) : void 0);
        default:
            var x = arguments[0];
            var y = arguments[1];
            var more = Array.prototype.slice.call(arguments, 2);
            return function loop() {
                var recur = loop;
                var previousø1 = x;
                var currentø1 = y;
                var indexø1 = 0;
                var countø1 = more.length;
                do {
                    recur = isEqual(previousø1, currentø1) && (indexø1 < countø1 ? (loop[0] = currentø1, loop[1] = (more || 0)[indexø1], loop[2] = inc(indexø1), loop[3] = countø1, loop) : true);
                } while (previousø1 = loop[0], currentø1 = loop[1], indexø1 = loop[2], countø1 = loop[3], recur === loop);
                return recur;
            }.call(this);
        }
    };
var equal = exports.equal = isEqual;
var isDeepEqual = exports.isDeepEqual = isEqual;
var deepEqual = exports.deepEqual = isEqual;
},{"./function":4,"./number":7,"./object":8,"./type":10}],4:[function(_dereq_,module,exports){
{
    var _ns_ = {
            id: 'hu.lib.macros',
            doc: void 0
        };
    var hu_lib_function = _dereq_('./function');
    var curry = hu_lib_function.curry;
    var compose = hu_lib_function.compose;
    var hu_lib_type = _dereq_('./type');
    var isString = hu_lib_type.isString;
    var isArray = hu_lib_type.isArray;
    var isObject = hu_lib_type.isObject;
}
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
{
    var _ns_ = {
            id: 'hu.lib.function',
            doc: void 0
        };
}
var bindFn = Function.prototype.bind;
var constant = exports.constant = function constant(x) {
        return function () {
            return x;
        };
    };
var identify = exports.identify = constant;
var apply = exports.apply = function apply(lambda, args) {
        return lambda.apply(lambda, args);
    };
var bind = exports.bind = function bind(lambda, ctx) {
        return bindFn.call(lambda, ctx);
    };
var partial = exports.partial = function partial(lambda) {
        var args = Array.prototype.slice.call(arguments, 1);
        return function () {
            var pargs = Array.prototype.slice.call(arguments, 0);
            return lambda.apply(void 0, args.concat(pargs));
        };
    };
var currier = function currier(lambda, arity, params) {
    return function curried() {
        var args = Array.prototype.slice.call(arguments, 0);
        return function () {
            var runø1 = Infinity === arity && args.length === 0;
            params ? args.unshift.apply(args, params) : void 0;
            return args.length >= arity || runø1 ? lambda.apply(void 0, args) : currier(lambda, arity, args);
        }.call(this);
    };
};
var curry = exports.curry = function curry(lambda) {
        var args = Array.prototype.slice.call(arguments, 1);
        return function () {
            var iargsø1 = lambda.length;
            var cargsø1 = args.length;
            var arityø1 = cargsø1 ? iargsø1 - cargsø1 : void 0;
            return currier(lambda, arityø1 || iargsø1, args);
        }.call(this);
    };
var compose = exports.compose = function compose(lambda) {
        var funcs = Array.prototype.slice.call(arguments, 1);
        return function () {
            var args = Array.prototype.slice.call(arguments, 0);
            return function () {
                var valø1 = lambda.apply(void 0, args);
                funcs.reduce(function (acc, lambda) {
                    return acc && lambda ? valø1 = lambda(acc) : void 0;
                }, valø1);
                return valø1;
            }.call(this);
        };
    };
var memoize = exports.memoize = function memoize(lambda, resolver) {
        return function () {
            var memoø1 = {};
            return function () {
                var args = Array.prototype.slice.call(arguments, 0);
                return function () {
                    var keyø1 = '@' + (resolver ? resolver.apply(void 0, args) : args[0]);
                    return memoø1.hasOwnProperty(keyø1) ? memoø1[keyø1] : memoø1[keyø1] = lambda.apply(void 0, args);
                }.call(this);
            };
        }.call(this);
    };
var wrap = exports.wrap = function wrap(lambda, to) {
        var args = Array.prototype.slice.call(arguments, 2);
        return function () {
            var cargs = Array.prototype.slice.call(arguments, 0);
            return to.apply(void 0, [lambda].concat(args, cargs));
        };
    };
var once = exports.once = function once(lambda) {
        return function () {
            var callø1 = true;
            var memoizedø1 = void 0;
            return function () {
                var args = Array.prototype.slice.call(arguments, 0);
                return callø1 ? (function () {
                    callø1 = false;
                    return memoizedø1 = lambda.apply(void 0, args);
                })() : memoizedø1;
            };
        }.call(this);
    };
var times = exports.times = function times(lambda, n) {
        return function () {
            var cø1 = 0;
            var nø2 = n || 1;
            var memoizedø1 = void 0;
            return function () {
                var args = Array.prototype.slice.call(arguments, 0);
                return cø1 < nø2 ? (function () {
                    cø1 = cø1 + 1;
                    return (cø1 === nø2 ? false : true) ? lambda.apply(void 0, args) : memoizedø1 = lambda.apply(void 0, args);
                })() : memoizedø1;
            };
        }.call(this);
    };
var defer = exports.defer = function defer(lambda, ms) {
        var args = Array.prototype.slice.call(arguments, 2);
        return setTimeout(function () {
            return lambda.apply(void 0, args);
        }, ms || 1000);
    };
var debounce = exports.debounce = function debounce() {
        var args = Array.prototype.slice.call(arguments, 0);
        return function () {
            var cargs = Array.prototype.slice.call(arguments, 0);
            return defer.apply(void 0, args.concat(cargs));
        };
    };
},{"./function":4,"./type":10}],5:[function(_dereq_,module,exports){
{
    var _ns_ = {
            id: 'hu.src.index',
            doc: void 0
        };
    var hu_src_equality = _dereq_('./equality');
    var equality = hu_src_equality;
    var hu_src_collection = _dereq_('./collection');
    var collection = hu_src_collection;
    var hu_src_type = _dereq_('./type');
    var type = hu_src_type;
    var hu_src_string = _dereq_('./string');
    var string = hu_src_string;
    var hu_src_number = _dereq_('./number');
    var number = hu_src_number;
    var hu_src_object = _dereq_('./object');
    var object = hu_src_object;
    var hu_src_array = _dereq_('./array');
    var array = hu_src_array;
    var hu_src_function = _dereq_('./function');
    var _function = hu_src_function;
    var hu_src_misc = _dereq_('./misc');
    var misc = hu_src_misc;
}
var hu = module.exports = object.extend.apply(void 0, [
        void 0,
        misc,
        type,
        string,
        number,
        array,
        object,
        _function,
        collection,
        equality
    ]);
hu.VERSION = '0.1.0';
},{"./array":1,"./collection":2,"./equality":3,"./function":4,"./misc":6,"./number":7,"./object":8,"./string":9,"./type":10}],6:[function(_dereq_,module,exports){
(function (global){
{
    var _ns_ = {
            id: 'hu.lib.macros',
            doc: void 0
        };
    var hu_lib_function = _dereq_('./function');
    var curry = hu_lib_function.curry;
    var compose = hu_lib_function.compose;
    var hu_lib_type = _dereq_('./type');
    var isString = hu_lib_type.isString;
    var isArray = hu_lib_type.isArray;
    var isObject = hu_lib_type.isObject;
}
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
{
    var _ns_ = {
            id: 'hu.lib.misc',
            doc: void 0
        };
}
var noop = exports.noop = function () {
        return void 0;
    };
var now = exports.now = Date.now;
var log = exports.log = function log() {
        var args = Array.prototype.slice.call(arguments, 0);
        return console ? console.log.apply(console, args) : void 0;
    };
var isBrowser = exports.isBrowser = (function () {
        return typeof(window) === 'object' && window.HTMLElement;
    })();
var _global = exports._global = isBrowser ? window : global;
}).call(this,typeof self !== "undefined" ? self : typeof window !== "undefined" ? window : {})
},{"./function":4,"./type":10}],7:[function(_dereq_,module,exports){
{
    var _ns_ = {
            id: 'hu.lib.macros',
            doc: void 0
        };
    var hu_lib_function = _dereq_('./function');
    var curry = hu_lib_function.curry;
    var compose = hu_lib_function.compose;
    var hu_lib_type = _dereq_('./type');
    var isString = hu_lib_type.isString;
    var isArray = hu_lib_type.isArray;
    var isObject = hu_lib_type.isObject;
}
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
{
    var _ns_ = {
            id: 'hu.lib.number',
            doc: void 0
        };
    var hu_lib_type = _dereq_('./type');
    var isNumber = hu_lib_type.isNumber;
}
var max = exports.max = Math.max;
var min = exports.min = Math.min;
var abs = exports.abs = Math.abs;
var round = exports.round = Math.round;
var random = exports.random = Math.random;
var floor = exports.floor = Math.floor;
var sin = exports.sin = Math.sin;
var tan = exports.tan = Math.tan;
var cos = exports.cos = Math.cos;
var asin = exports.asin = Math.asin;
var atan = exports.atan = Math.atan;
var atan2 = exports.atan2 = Math.atan2;
var ceil = exports.ceil = Math.ceil;
var exp = exports.exp = Math.exp;
var sqrt = exports.sqrt = Math.sqrt;
var PI = exports.PI = Math.PI;
var odd = exports.odd = function odd(n) {
        return n % 2 > 0 || n % 2 < 0;
    };
var isOdd = exports.isOdd = odd;
var even = exports.even = function even(n) {
        return n % 2 === 0;
    };
var isEven = exports.isEven = even;
var lower = exports.lower = function lower() {
        var args = Array.prototype.slice.call(arguments, 0);
        return curry(function (x, y) {
            return x < y;
        }).apply(void 0, args);
    };
var isLower = exports.isLower = lower;
var higher = exports.higher = function higher() {
        var args = Array.prototype.slice.call(arguments, 0);
        return curry(function (x, y) {
            return x > y;
        }).apply(void 0, args);
    };
var isHigher = exports.isHigher = higher;
var inc = exports.inc = function inc(x) {
        return x + 1;
    };
var dec = exports.dec = function dec(x) {
        return x - 1;
    };
var signum = exports.signum = function signum(x) {
        return x === 0 ? 0 : x < 0 ? -1 : x > 0 ? 1 : void 0;
    };
var isNegative = exports.isNegative = function isNegative(x) {
        return x < 0;
    };
var negate = exports.negate = function negate(x) {
        return abs(x) * (signum(x) >= 0 ? -1 : 1);
    };
var recip = exports.recip = function recip(x) {
        return 1 / x;
    };
var div = exports.div = function div() {
        var args = Array.prototype.slice.call(arguments, 0);
        return curry(function (x, y) {
            return floor(x / y);
        }).apply(void 0, args);
    };
},{"./function":4,"./type":10}],8:[function(_dereq_,module,exports){
{
    var _ns_ = {
            id: 'hu.lib.macros',
            doc: void 0
        };
    var hu_lib_function = _dereq_('./function');
    var curry = hu_lib_function.curry;
    var compose = hu_lib_function.compose;
    var hu_lib_type = _dereq_('./type');
    var isString = hu_lib_type.isString;
    var isArray = hu_lib_type.isArray;
    var isObject = hu_lib_type.isObject;
}
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
{
    var _ns_ = {
            id: 'hu.lib.object',
            doc: void 0
        };
    var hu_lib_type = _dereq_('./type');
    var isDate = hu_lib_type.isDate;
    var isArray = hu_lib_type.isArray;
    var isObject = hu_lib_type.isObject;
    var isFn = hu_lib_type.isFn;
}
var hasOwn = Object.prototype.hasOwnProperty;
var has = exports.has = function has() {
        var args = Array.prototype.slice.call(arguments, 0);
        return curry(function (obj, prop) {
            return hasOwn.call(obj, prop);
        }).apply(void 0, args);
    };
var keys = exports.keys = function keys(obj) {
        return Object.keys(obj);
    };
var vals = exports.vals = function vals(obj) {
        return keys(obj).map(function (key) {
            return (obj || 0)[key];
        });
    };
var extend = exports.extend = function extend(target) {
        var origins = Array.prototype.slice.call(arguments, 1);
        var obj = isObject(target) ? target : {};
        origins.reduce(function (origin, o, index) {
            isObject(origin) ? keys(origin).forEach(function (name) {
                return obj[name] = origin[name];
            }) : void 0;
            return origins[index + 1];
        }, origins[0]);
        return obj;
    };
var assign = exports.assign = extend;
var mixin = exports.mixin = function mixin(target) {
        var origins = Array.prototype.slice.call(arguments, 1);
        var obj = isObject(target) ? target : {};
        origins.reduce(function (origin, _, index) {
            isObject(origin) ? keys(origin).forEach(function (name) {
                return isFn(origin[name]) ? obj[name] = origin[name] : void 0;
            }) : void 0;
            return origins[index + 1];
        }, origins[0]);
        return obj;
    };
var clone = exports.clone = function clone(obj) {
        return isArray(obj) ? obj.slice() : isObject(obj) ? extend({}, obj) : isDate(obj) ? new Date(obj.getTime()) : obj;
    };
var keyValues = exports.keyValues = function keyValues(obj) {
        return keys(obj).map(function (key) {
            return [
                key,
                (obj || 0)[key]
            ];
        });
    };
var pairs = exports.pairs = keyValues;
var toObject = exports.toObject = function toObject() {
        var pairs = Array.prototype.slice.call(arguments, 0);
        return function loop() {
            var recur = loop;
            var keyValuesø1 = pairs;
            var resultø1 = {};
            do {
                recur = keyValuesø1.length ? (function () {
                    resultø1[keyValuesø1[0]] = keyValuesø1[1];
                    return loop[0] = keyValuesø1.slice(2), loop[1] = resultø1, loop;
                })() : resultø1;
            } while (keyValuesø1 = loop[0], resultø1 = loop[1], recur === loop);
            return recur;
        }.call(this);
    };
var __oproto__ = Object.prototype;
var merge = exports.merge = function merge() {
        var args = Array.prototype.slice.call(arguments, 0);
        return Object.create(__oproto__, args.reduce(function (descriptor, obj) {
            isObject(obj) ? keys(obj).forEach(function (key) {
                return (descriptor || 0)[key] = Object.getOwnPropertyDescriptor(obj, key);
            }) : void 0;
            return descriptor;
        }, {}));
    };
var map = exports.map = function map() {
        var args = Array.prototype.slice.call(arguments, 0);
        return curry(function (source, cb) {
            return keys(source).reduce(function (target, key) {
                target[key] = cb(source[key], key, source);
                return target;
            }, source);
        }).apply(void 0, args);
    };
var mapValues = exports.mapValues = map;
var filter = exports.filter = function filter() {
        var args = Array.prototype.slice.call(arguments, 0);
        return curry(function (source, cb) {
            return function () {
                var targetø1 = {};
                keys(source).reduce(function (target, key) {
                    cb(source[key], key, source) ? target[key] = source[key] : void 0;
                    return target;
                }, targetø1);
                return targetø1;
            }.call(this);
        }).apply(void 0, args);
    };
var filterValues = exports.filterValues = filter;
},{"./function":4,"./type":10}],9:[function(_dereq_,module,exports){
{
    var _ns_ = {
            id: 'hu.lib.macros',
            doc: void 0
        };
    var hu_lib_function = _dereq_('./function');
    var curry = hu_lib_function.curry;
    var compose = hu_lib_function.compose;
    var hu_lib_type = _dereq_('./type');
    var isString = hu_lib_type.isString;
    var isArray = hu_lib_type.isArray;
    var isObject = hu_lib_type.isObject;
}
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
{
    var _ns_ = {
            id: 'hu.lib.string',
            doc: void 0
        };
    var hu_lib_type = _dereq_('./type');
    var isString = hu_lib_type.isString;
    var isArray = hu_lib_type.isArray;
    var isNumber = hu_lib_type.isNumber;
    var hu_lib_object = _dereq_('./object');
    var keys = hu_lib_object.keys;
}
var EOL = /[\n|\r]/;
var subs = exports.subs = function subs(x, start, end) {
        return isString(x) ? x.substring(start, end) : x;
    };
var lines = exports.lines = function lines(x) {
        return isString(x) ? x.split(EOL) : x;
    };
var unlines = exports.unlines = function unlines(x) {
        return isArray(x) ? x.join('\n') : x;
    };
var words = exports.words = function words(x) {
        return isString(x) ? x.split(/[ ]+/) : x;
    };
var unwords = exports.unwords = function unwords(x) {
        return isArray(x) ? x.join(' ') : x;
    };
var chars = exports.chars = function chars(x) {
        return isString(x) ? x.split('') : x;
    };
var unchars = exports.unchars = function unchars(x) {
        return isArray(x) ? x.join('') : x;
    };
var char = exports.char = function char(x) {
        return isNumber(x) ? String.fromCharCode(x) : void 0;
    };
var reverse = exports.reverse = function reverse(x) {
        return isString(x) ? x.split('').reverse().join('') : x;
    };
var repeat = exports.repeat = function repeat(n, x) {
        return isString(x) ? n > 0 ? x + repeat(n - 1, x) : '' : x;
    };
var htmlEscapes = {
        '&': '&amp;',
        '<': '&lt;',
        '>': '&gt;',
        '"': '&quot;',
        '\'': '&#39;'
    };
var unescapedHtml = new RegExp('[' + keys(htmlEscapes).join() + ']', 'g');
var escapeChar = function escapeChar(x) {
    return htmlEscapes[x];
};
var escape = exports.escape = function escape(x) {
        return isString(x) ? String(x).replace(unescapedHtml, escapeChar) : '';
    };
},{"./function":4,"./object":8,"./type":10}],10:[function(_dereq_,module,exports){
{
    var _ns_ = {
            id: 'hu.lib.macros',
            doc: void 0
        };
    var hu_lib_function = _dereq_('./function');
    var curry = hu_lib_function.curry;
    var compose = hu_lib_function.compose;
    var hu_lib_type = _dereq_('./type');
    var isString = hu_lib_type.isString;
    var isArray = hu_lib_type.isArray;
    var isObject = hu_lib_type.isObject;
}
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
{
    var _ns_ = {
            id: 'hu.lib.type',
            doc: void 0
        };
    var hu_lib_misc = _dereq_('./misc');
    var isBrowser = hu_lib_misc.isBrowser;
    var _global = hu_lib_misc._global;
}
var objToStr = Object.prototype.toString;
var toStr = function toStr(x) {
    return objToStr.call(x);
};
var isNull = exports.isNull = function isNull(x) {
        return x === null;
    };
var isUndef = exports.isUndef = function isUndef(x) {
        return typeof(x) === 'undefined' || isNull(x);
    };
var isUndefined = exports.isUndefined = isUndef;
var isBool = exports.isBool = function isBool(x) {
        return x === true || x === false || toString.call(x) === '[object Boolean]';
    };
var isBoolean = exports.isBoolean = isBool;
var isNumber = exports.isNumber = function isNumber(x) {
        return toStr(x) === '[object Number]';
    };
var isFinite = exports.isFinite = function isFinite(x) {
        return _global.isFinite(x) && !isNaN(parseFloat, x);
    };
var isNaN = exports.isNaN = function isNaN(x) {
        return x === x ? false : true;
    };
var isSymbol = exports.isSymbol = function isSymbol(x) {
        return toStr(x) === '[object Symbol]';
    };
var isString = exports.isString = function isString(x) {
        return toStr(x) === '[object String]';
    };
var isDate = exports.isDate = function isDate(x) {
        return toStr(x) === '[object Date]';
    };
var isRegExp = exports.isRegExp = function isRegExp(x) {
        return toStr(x) === '[object RegExp]';
    };
var isPattern = exports.isPattern = isRegExp;
var isArgs = exports.isArgs = function isArgs(x) {
        return toStr(x) === '[object Arguments]';
    };
var isArguments = exports.isArguments = isArgs;
var isFunction = exports.isFunction = function isFunction(x) {
        return typeof(x) === 'function';
    };
var isFn = exports.isFn = isFunction;
var isObject = exports.isObject = function isObject(x) {
        return toStr(x) === '[object Object]';
    };
var isArray = exports.isArray = isFn(Array.isArray) ? Array.isArray : function (x) {
        return toStr(x) === '[object Array]';
    };
var isError = exports.isError = function isError(x) {
        return toStr(x) === '[object Error]';
    };
var isPlainObject = exports.isPlainObject = function isPlainObject(x) {
        return isObject(x) && isObject(Object.getPrototypeOf(x)) && isNull(Object.getPrototypeOf(Object.getPrototypeOf(x)));
    };
var isElement = exports.isElement = function isElement(x) {
        return isBrowser ? toStr(x).indexOf('Element') >= 0 : false;
    };
var isMutable = exports.isMutable = function isMutable(x) {
        return isObject(x) || isArray(x) || isError(x) || isArgs(x) || isDate(x) || isFunction(x);
    };
var isEmpty = exports.isEmpty = function isEmpty(x) {
        return isUndef(x) || (isObject(x) ? Object.keys(x).length === 0 ? true : false : false) || x.length === 0;
    };
var notEmpty = exports.notEmpty = function notEmpty(x) {
        return !isEmpty(x);
    };
var isNotEmpty = exports.isNotEmpty = notEmpty;
var isPrimitive = exports.isPrimitive = function isPrimitive(x) {
        return isNull(x) || isBool(x) || isRegExp(x) || isString(x) || isNumber(x) || isSymbol(x);
    };
var isIterable = exports.isIterable = function isIterable(x) {
        return isObject(x) || isArray(x) || isArgs(x);
    };
var canIterate = exports.canIterate = isIterable;
},{"./function":4,"./misc":6,"./type":10}]},{},[5])
(5)
});