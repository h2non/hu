# hu

## About

**hu** is a tiny utility helper library designed to be easily embedded or bundled in applications
without hurting your feelings.
It provides a set of trivial utility functions that you probably are constantly looking in each new application

As you probably already know about underscore, lodash or sugar.js,
hu only provides the most common required functions for general purposes, keeping it as a
lightweight library that can be embedded as a part of your application, library or framework

## Features

- Type check helpers
- Iterators and transformer helpers
- Tiny. 1000 SLOC. 2KB minified
- Runs over node and modern browsers
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

### Example
```
var hu = require('hu')

hu.each(obj, function (val, index) {
  console.log(val, index)
})
```

## Contributing

Wanna help? Cool! It will be really apreciated :)

You must add new test cases for any new feature or refactor you do,
always following the same design/code patterns that already exist

Tests specs are completely written in Wisp language.
Take a look to the language [documentation][wisp-doc] if you are new with it.
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

[wisp-doc]: https://github.com/Gozala/wisp
