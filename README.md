# hu [![Build Status](https://secure.travis-ci.org/h2non/hu.png?branch=master)][travis] [![Dependency Status](https://gemnasium.com/h2non/hu.png)][gemnasium] [![NPM version](https://badge.fury.io/js/hu.png)][npm]

> **Disclaimer**: hu is still a just-for-fun and learn experimental project

<table>
<tr>
<td><b>Version</b></td><td>beta</td>
</tr>
<tr>
<td><b>Stage</b></td><td>experimental</td>
</tr>
<tr>
<td><b>Fun</b></td><td>true</td>
</tr>
</table>

## About

**hu** is a functional-oriented utility helper library
inspired by haskell's prelude and lodash/underscore

Instead of other well-knowed libraries sush as Lodash or Sugar.js, hu only provides a reduced but generic set of most common and useful functions.
It aims to be a lightweight and small library which can be easily embeded as a part of an application, library or framework without making noise

hu helper functions are almost curried.
It's still a just-for-fun experimental project. It should be pronuncied `ju`

### Motivation

Functional programming tendency has grown (again) in the latest years.
This paradigm, instead of others more totalitary, extended and adopted
like object-oriented, forces a radical re-thinking
in the way that programmers design and implement software

Functional programming thinking and conversion is not easy to apply,
but it's really attractive and funny paradigm,
which assist to solve the same problems from a theorical
and conceptually clean way (and sometimes more efficiently)

### Rationale

A good aproach to learn and apply functional programming principles
is creating a functional-oriented library that assists by it self to
do functional programming

hu was created to define an real scenario to do funny experiments
with some pure functional programming principles

It's completely written in [Wisp][wisp], a homoiconic Clojure-like language which compiles into plain JavaScript that supports s-expressions and macros, allowing to extend the compiler features with own user code

### Challenges

hu is a library designed to run over ES5 compilant engines
JavaScript is a ubiquitous well-extended, multi-purpose and multi-paradigm cool language

JavaScript is in fact a not pure functional language, however
its natural extensibility allows to apply different paradigms to it and today a lot of languages that transpiles into JavaScript helps with that

hu is implemented keeping in mind the following ambitious goals:

- Assume it's a first-class function only language
- Pure functions as a norm
- Unmutability (when it's possible)
- Avoid assignment, remove side-effects (when it's possible)
- Tend to recursion instead of loops
- Tend to high-order functions
- Tend to functional composition
- Tend to continuation-passing style
- Exploit subroutines (like tail recursion call)
- Exploit memoization (currying, partial, caching...)
- Exploit combinators
- Exploit macros (and protocols in a future)

## Features

- Data structures
- Type check helpers
- Iterators and transformer helpers
- Runs over node and browsers
- Well tested with high coverage

## Installation

#### Node.js

```
$ npm install hu
```

#### Browser

Via Bower package manager
```
$ bower install hu
```

Or loading the script remotely (just for testing or development)
```html
<script src="//rawgithub.com/h2non/hu/master/hu.js"></script>
```

## Environments

It works properly in any ES5 compliant environment, however just for
a formalism, those environments are:

- Node.js
- Chrome >= 5
- Firefox
- Safari >= 5
- Opera >= 12
- IE >= 9

## API

- [Type checking](#type-checking)
  - [isBool(value)](#isboolvalue)
  - [isNumber(value)](#isnumbervalue)
  - [isFinite(value)](#isfinitevalue)
  - [isString(value)](#isstringvalue)
  - [isSymbol(value)](#issymbolvalue)
  - [isFunction(value)](#isfunctionvalue)
  - [isDate(value)](#isdatevalue)
  - [isRegExp(value)](#isregexpvalue)
  - [isArray(value)](#isarrayvalue)
  - [isObject(value)](#isobjectvalue)
  - [isPlainObject(value)](#isplainobjectvalue)
  - [isError(value)](#iserrorvalue)
  - [isElement(value)](#iselementvalue)
  - [isArgs(value)](#isargsvalue)
  - [isUndef(value)](#isundefvalue)
  - [isNull(value)](#isnullvalue)
  - [isEmpty(value)](#isemptyvalue)
  - [isMutable(value)](#ismutablevalue)
  - [isPrimitive(value)](#isprimitivevalue)
  - [isIterable(value)](#isiterablevalue)
  - [isEqual(x, y)](#isequalx-y)
  - [isObjectEqual(x, y)](#isobjectequalx-y)
- [Strings](#strings)
  - [escape(str)](#escapestr)
  - [subs(str, start, end)](#subsstr-start-end)
  - [reverse(str)](#reversestr)
  - [repeat(number, str)](#repeatnumber-str)
  - [lines(str)](#linesstr)
  - [unlines(arr)](#unlinesarr)
  - [words(str)](#wordsstr)
  - [unwords(arr)](#unwordsarr)
  - [chars(str)](#charsstr)
  - [unchars(arr)](#uncharsarr)
  - [char(number)](#charnumber)
- [Numbers](#numbers)
  - [isOdd(number)](#isoddnumber)
  - [isEven(number)](#isevennumber)
  - [max(...numbers)](#maxnumbers)
  - [min(...numbers)](#minnumbers)
  - [inc(number)](#incnumber)
  - [dec(number)](#decnumber)
  - [int(float)](#intfloat)
- [Arrays](#arrays)
  - [has-array(arr, element)](#has-arrayarr-element)
  - [isArrayEqual(x, y)](#isarrayequalx-y)
- [Objects](#objects)
  - [has(obj, property)](#hasobj-property)
  - [keys](#keys)
  - [values](#values)
  - [extend(target, origin)](#extendtarget-origin)
  - [mixin(target, origin)](#mixintarget-origin)
  - [clone(object)](#cloneobject)
- [Collections](#collections)
  - [each(obj, function, ctx)](#eachobj-function-ctx)
- [Functions](#functions)
  - [constant(value)](#constantvalue)
  - [apply(function, [ arguments ])](#applyfunction--arguments-)
  - [bind(function, ctx)](#bindfunction-ctx)
  - [equal(x, y)](#equalx-y)
  - [deepEqual(x, y)](#deepequalx-y)
- [Miscellaneous](#miscellaneous)
  - [log(...msg)](#logmsg)
  - [isBrowser()](#isbrowser)
  - [noop()](#noop)
  - [now()](#now)

### Overview example

```js
var { log map clean } = require('hu')

log(map(clean({ a: 'value', b: null })).join(', '))
```

```livescript
a: 'value', b: null |> clean |> map |> log
```

### Type checking

#### isBool(value)
Return: `boolean`

Checks if the given value is a boolean type

#### isNumber(value)
Return: `boolean`

Checks if the given value is a number type

#### isFinite(value)
Return: `boolean`

Checks if the given value is a finite number,
or it can be coerced into it

#### isString(value)
Return: `boolean`

Checks if the given value is a string type

#### isSymbol(value)
Return: `boolean`

Checks if the given value is a symbol type

#### isFunction(value)
Return: `boolean` | Alias: `isFn`

Checks if the given value is a function type

#### isDate(value)
Return: `boolean`

Checks if the given value is a date type

#### isRegExp(value)
Return: `boolean` | Alias: `isPattern`

Checks if the given value is a regexp type

#### isArray(value)
Return: `boolean`

Checks if the given value is a array type

#### isObject(value)
Return: `boolean`

Checks if the given value is a object type

#### isPlainObject(value)
Return: `boolean`

Checks if the given value is a native object type (it was createdd by the Object native constructor)

#### isError(value)
Return: `boolean`

Checks if the given value is a error type

#### isElement(value)
Return: `boolean`

Checks if the given value is a DOM element object instance

#### isArgs(value)
Return: `boolean`

Checks if the given value is a arguments type

#### isUndef(value)
Return: `boolean`

Checks if the given value is a undefined, void o null type

#### isNull(value)
Return: `boolean`

Checks if the given value is a null type

#### isEmpty(value)
Return: `boolean`

Checks if the given value is empty.
Arrays, strings, or arguments objects with a length of 0 and objects with no own enumerable properties are considered empty values

#### isMutable(value)
Return: `boolean`

Checks if the given value is a mutable data type.
Objects, arrays, date objects, arguments objects and functions are considered mutable data types

#### isPrimitive(value)
Return: `boolean`

Checks if the given value is a primitive value type
Strings, numbers, booleans, symbols and null are considered primitives values

#### isIterable(value)
Return: `boolean`

Checks if the given value can be iterated.
Objects, arrays, and arguments objects are considered iterables data types

#### isEqual(x, y)
Return: `boolean` | Alias: `isDeepEqual`

Checks if the given values are equals.
It also performs a deep comparison between two values to determine
if both are types equivalent

#### isObjectEqual(x, y)
Return: `boolean`

Checks if the given object values and keys are equals

### Strings

#### escape(str)
Return: `string`

Converts the characters &, <, >, ", and ' in the given string
to their corresponding HTML entities

#### subs(str, start, end)
Return: `string`

Extract characters from the given string

#### reverse(str)
Return: `string`

Reverse characters of the given string

#### repeat(number, str)
Return: `string`

Repeat the given string

#### lines(str)
Return: `array`

Split the given string by end of line tokens

#### unlines(arr)
Return: `string`

Join the given array into a string separated by
end line token

#### words(str)
Return: `array`

Returns an array of words (spaces separated)

#### unwords(arr)
Return: `string`

Join words of the given array into a string spaces separated

#### chars(str)
Return: `array`

Return an array of characters of the given string

#### unchars(arr)
Return: `string`

Join the strings of the given array

#### char(number)
Return: `string`

Return the given unicode number into his
equivalent character

### Numbers

#### isOdd(number)
Return: `boolean`

Return `true` if the given number is odd

#### isEven(number)
Return: `boolean`

Return `true` if the given number is even

#### max(...numbers)
Return: `number`

Returns the number with the highest value

#### min(...numbers)
Return: `number`

Returns the number with the lower value

#### inc(number)
Return: `number`

Increment the given value

#### dec(number)
Return: `number`

Decrement the given value

#### int(float)
Return: `number`

Coerce to integer number by stripping decimal places

### Arrays

#### has-array(arr, element)
Return: `boolean`

Returns `true if vector contains given element

#### isArrayEqual(x, y)
Return: `boolean`

Return `true` if the given arrays are equals

### Objects

#### has(obj, property)
Return: `boolean`

Checks if the specified property name exists as a
own property of the given object

#### keys(obj)
Return: `array`

Returns a sequence of the map's keys

#### vals(obj)
Return: `array`

Returns a sequence of the map's values

#### keyValues(obj)
Return: `array` | Alias: `pairs`

Returns a two dimensional array of an object’s key-value pairs

#### toObject(obj)
Return: `array`

Creates an object of given arguments.
Odd indexed arguments are used for keys and evens for values

#### keyValues(obj)
Return: `array`

Returns a sequence of the map's values

#### extend(target, ...origins)
Return: `object` | Alias: `assign`

Assigns own enumerable properties of source object(s) to the destination object

#### mixin(target, ...origins)
Return: `object`

Adds function properties of a source object to the destination object

#### clone(object)
Return: `object`

Creates a clone of the given object

#### merge(x, y)
Return: `object`

Similar to `extend`, it returns an object that consists
of the rest of the maps conj-ed onto the first

If a key occurs in more than one map, the mapping from
the latter (left-to-right) will be the mapping in the result

### Collections

#### each(obj, function)
Return: `void` | Alias:  `forEach`

Iterates over elements of an iterable object,
executing the callback for each element

#### filter(obj, function)
Return: `array`

Iterates over elements of a collection, returning an array of all elements the callback returns truey for

### Functions

#### constant(value)
Return: `function`

Returns a function that returns the given value.
Useful for function composition

#### apply(function, args)
Return: `mixed`

Invokes a function without binding a context
with the given arguments as array

```js
function myFn(x, y) {}
apply(myFn, [1, 2])
```

#### bind(function, ctx)
Return: `function`

Invokes a function without binding a context
with the given arguments as array

```js
function myFn(x, y) {}
apply(myFn, [1, 2])
```

#### compose(...fn)
Return: `function`

Creates a function that is the composition of the provided functions, where each function consumes the return value of the function that follows

#### partial(fn, [ ...partialArgs ])
Return: `function`

```js
```

#### curry(fn, [ ctx ])
Return: `function`

```js
var fn = function () { }
add-curried = curry add
add-four = add-curried 4
add-four 2 #=> 6
```

#### wrap(fn, wrapperFn, [ ...args ])
Return: `function`

Wraps the first function inside of the wrapper function, passing it as the first argument
Aditionally you can define partial arguments that will  be passed to the wrapper

```js
var hello = function (name) { return "hi " + name; };
hello = hu.wrap(hello, function (func, text, type) {
  return "before, " + func("moe") + ", " + text + ": " + type + ", after";
}, "type");
hello("salutation");
//=> 'before, hi moe, type: salutation, after'
```

#### once(fn)
Return: `function`

Creates a function that is restricted to execute once unique time.
Subsuquents calls to the function will return the memoized value of the initial call

```js
var hello = function (name) { return "hi " + name; };
hello = hu.once(hello);
hello("salutation");
//=> 'before, hi moe, type: salutation, after'
```

#### times(fn, number)
Return: `function`

Creates a function that is restricted to be executed a maximun number of times.
Subsuquents calls to the function will return the memoized value of the latest call

```js
var hello = function (name) { return "hi " + name; };
hello = hu.once(hello);
hello("salutation");
//=> 'before, hi moe, type: salutation, after'
```

#### delay(fn, ms, [ ...args ])
Return: `void`

Executes the given function after wait milliseconds. You can provide arguments that will be passed to the function when it's invoked

#### defer(fn, ms, [ ...args ])
Return: `function`

Return a function that exectures the given function after wait milliseconds.
You can provide arguments that will be passed to the function when it's invoked

### Equality

#### isEqual(x, y)
Return: `boolean` | Alias: `equal`

#### deepEqual(x, y)
Return: `boolean` | Alias: `deepEqual`

#### isPatternEqual
Return: `boolean` | Alias: `isRegExpEqual`

#### isArrayEqual
Return: `boolean`

#### isObjectEqual
Return: `boolean`

Check if two objects has the same value types on its properties

### Miscellaneous

#### log(...msg)
Return: `undefined`

Write the given arguments in the console

#### isBrowser()
Return: `boolean`

Checks if the current runtime JavaScript environment is in a browser context

#### noop()
Return: `void`

The no-operation function, that returns `void`

#### now()
Return: `number`

Returns an integer timestamp for the current time

## Contributing

Wanna help? Cool! It will be really apreciated :)

You must add new test cases for any new feature or refactor you do,
always following the same design/code patterns that already exist

Tests specs are completely written in Wisp language.
Take a look to the language [documentation][wisp] if you are new with it.
You should follow the Wisp language coding conventions

### Development

Only [node.js](http://nodejs.org) is required for development

Clone/fork this repository
```
$ git clone https://github.com/h2non/hu.git && cd hu
```

Install package dependencies
```
$ npm install
```

Compile code
```
$ make compile
```

Run tests
```
$ make test
```

Browser sources bundle generation
```
$ make browser
```

Release a new version
```
$ make release
```

## License

Copyright (c) Tomas Aparicio

Released under the MIT license

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/h2non/hu.js/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

[wisp]: https://github.com/Gozala/wisp
[travis]: http://travis-ci.org/h2non/hu
[gemnasium]: https://gemnasium.com/h2non/hu
[npm]: http://npmjs.org/package/hu
