BROWSERIFY = node ./node_modules/browserify/bin/cmd.js
WISP = ./node_modules/wisp/bin/wisp.js
WISP_MODULE = ./node_modules/wisp/
MOCHA = ./node_modules/.bin/mocha
UGLIFYJS = ./node_modules/.bin/uglifyjs
BANNER = "/*! hu.js - v0.1 - MIT License - https://github.com/h2non/hu */"

define release
	VERSION=`node -pe "require('./package.json').version"` && \
	NEXT_VERSION=`node -pe "require('semver').inc(\"$$VERSION\", '$(1)')"` && \
	node -e "\
		var j = require('./package.json');\
		j.version = \"$$NEXT_VERSION\";\
		var s = JSON.stringify(j, null, 2);\
		require('fs').writeFileSync('./package.json', s);" && \
	node -e "\
		var j = require('./bower.json');\
		j.version = \"$$NEXT_VERSION\";\
		var s = JSON.stringify(j, null, 2);\
		require('fs').writeFileSync('./bower.json', s);" && \
	git commit -am "release $$NEXT_VERSION" && \
	git tag "$$NEXT_VERSION" -m "Version $$NEXT_VERSION"
endef

define replace
	node -e "\
		var fs = require('fs'); \
		var os = require('os-shim'); \
		var str = fs.readFileSync('./hu.js').toString(); \
		str = str.split(os.EOL).map(function (line) { \
		  return line.replace(/^void 0;/, '') \
		}).filter(function (line) { \
		  return line.length \
		}).join(os.EOL); \
		fs.writeFileSync('./hu.js', str)"
endef

default: all
all: test browser
browser: cleanbrowser test banner browserify replace uglify
test: compile mocha

mkdir:
	mkdir -p lib

compile: mkdir clean
	cat src/macros.wisp src/string.wisp | $(WISP) --no-map > ./lib/string.js
	cat src/macros.wisp src/number.wisp | $(WISP) --no-map > ./lib/number.js
	cat src/macros.wisp src/type.wisp | $(WISP) --no-map > ./lib/type.js
	cat src/macros.wisp src/object.wisp | $(WISP) --no-map > ./lib/object.js
	cat src/macros.wisp src/array.wisp | $(WISP) --no-map > ./lib/array.js
	cat src/macros.wisp src/maths.wisp | $(WISP) --no-map > ./lib/maths.js
	cat src/macros.wisp src/collection.wisp | $(WISP) --no-map > ./lib/collection.js
	cat src/macros.wisp src/function.wisp | $(WISP) --no-map > ./lib/function.js
	cat src/macros.wisp src/equality.wisp | $(WISP) --no-map > ./lib/equality.js
	cat src/macros.wisp src/misc.wisp | $(WISP) --no-map > ./lib/misc.js
	cat src/hu.wisp | $(WISP) --no-map > ./lib/hu.js

banner:
	@echo $(BANNER) > hu.js

browserify:
	$(BROWSERIFY) \
		--exports require \
		--standalone hu \
		--entry ./lib/hu.js >> ./hu.js

replace:
	@$(call replace)

uglify:
	$(UGLIFYJS) hu.js --mangle --preamble $(BANNER) > hu.min.js

clean:
	rm -rf lib/*

cleanbrowser:
	rm -f *.js

mocha:
	$(MOCHA) --reporter spec --ui tdd --compilers wisp:$(WISP_MODULE)

loc:
	wc -l src/*

release:
	@$(call release, patch)

release-minor:
	@$(call release, minor)

publish: browser release
	git push --tags origin HEAD:master
	npm publish
