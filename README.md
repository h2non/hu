# hu [![Build Status](https://secure.travis-ci.org/h2non/hu.png?branch=master)][travis] [![Dependency Status](https://gemnasium.com/h2non/hu.png)][gemnasium] [![NPM version](https://badge.fury.io/js/hu.png)][npm]

> Spoiler! Funny work still in progress!

<table>
<tr>
<td><b>Version</b></td><td>beta</td>
</tr>
<tr>
<td><b>Stage</b></td><td>experimental</td>
</tr>
</table>

## About

**hu** is a tiny functional utility helper library
which provides the most common and missing functions
that are required in any JavaScript project

Instead of Underscore, Lodash or Sugar.js, hu only provides
a reduced set of the most common functions, keeping it as a lightweight
and tiny library designed to be easy to embed as part of an application, library or framework

It's pronuncied `ji-u`

## Rationale

hu was created to define an real scenario to do funny experiments
with some pure functional programming principles

It's completely written in [Wisp][wisp], a homoiconic Clojure-like language which compiles into plain JavaScript that supports s-expressions and macros, allowing to extend the compiler features with own user code

Some of the ambitious implementation goals are:

- First-class functions
- Pure functions and high-order functions
- Unmutability (when it's possible)
- Avoid assignment, remove side-effects (when it's possible)
- Use recursion instead of loops
- Tend to continuation-passing style
- Exploit subroutines (like tail recursion call)
- Exploit memoization (currying, partial) and caching
- Exploit combinators

## Features

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

- Node.js
- Chrome
- Firefox
- Safari >= 5
- Opera >= 11.6
- IE >= 9

## API

- [Types](#types)
  - [isBool](#isboolvalue)
  - [isNumber](#isnumbervalue)
  - [isFinite](#isfinitevalue)
  - [isString](#isstringvalue)
  - [isSymbol](#issymbolvalue)
  - [isFunction](#isfunctionvalue)
  - [isDate](#isdatevalue)
  - [isRegExp](#isregexpvalue)
  - [isArray](#isarrayvalue)
  - [isObject](#isobjectvalue)
  - [isPlainObject](#isplainobjectvalue)
  - [isError](#iserrorvalue)
  - [isElement](#iselementvalue)
  - [isArgs](#isargsvalue)
  - [isUndef](#isundefvalue)
  - [isNull](#isnullvalue)
  - [isEmpty](#isemptyvalue)
  - [isMutable](#ismutablevalue)
  - [isPrimitive](#isprimitivevalue)
  - [isIterable](#isiterablevalue)
  - [isEqual](#isequalx-y)
  - [isObjectEqual](#isobjectequalx-y)
  - [isBrowser](#isbrowser)
- [Misc](#misc)
  - [log](#logmsg)
- [Strings](#strings)
  - [subs](#subs)
  - [lines](#lines)
  - [unlines](#unlines)
  - [words](#words)
  - [unwords](#unwords)
  - [chars](#chars)
  - [unchars](#unchars)
- [Numbers](#numbers)
- [Lists](#lists)
- [Objects](#objects)
- [Collections](#collections)
- [Functions](#functions)

### Types

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
Return: `boolean`

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

#### isBrowser()
Return: `boolean`

Checks if the current runtime JavaScript environment is in a browser context

### Misc

#### log(...msg)
Return: `undefined`

Write the given arguments in the console

### Strings

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

### Numbers

### Lists

### Objects

### Collections

### Functions



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
