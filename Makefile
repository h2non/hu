BROWSERIFY = node ./node_modules/browserify/bin/cmd.js
WISP = ./node_modules/wisp/bin/wisp.js
WISP_MODULE = ./node_modules/wisp/
MOCHA = ./node_modules/.bin/mocha
UGLIFYJS = ./node_modules/.bin/uglifyjs
BANNER = "/*! hu.js - v0.1.0 - MIT License - https://github.com/h2non/hu */"

default: all
all: test browser
browser: cleanbrowser test banner browserify uglify
compile: mkdir clean index string number common object array function
test: compile runtest

mkdir:
	mkdir -p lib

string:
	cat src/string.wisp | $(WISP) --source-uri src/string.wisp --no-map > ./lib/string.js

number:
	cat src/number.wisp | $(WISP) --source-uri src/number.wisp --no-map > ./lib/number.js

common:
	cat src/common.wisp | $(WISP) --source-uri src/common.wisp --no-map > ./lib/common.js

object:
	cat src/object.wisp | $(WISP) --source-uri src/object.wisp --no-map > ./lib/object.js

array:
	cat src/array.wisp | $(WISP) --source-uri src/array.wisp --no-map > ./lib/array.js

function:
	cat src/function.wisp | $(WISP) --source-uri src/function.wisp --no-map > ./lib/function.js

index:
	cat src/hu.wisp | $(WISP) --source-uri src/hu.wisp --no-map > ./lib/hu.js

banner:
	@echo $(BANNER) > hu.js

browserify:
	$(BROWSERIFY) \
		--exports require \
		--standalone hu \
		--entry ./lib/hu.js >> ./hu.js

uglify:
	$(UGLIFYJS) hu.js --mangle --preamble $(BANNER) > hu.min.js

clean:
	rm -rf lib/*

cleanbrowser:
	rm -f *.js

runtest:
	$(MOCHA) --reporter spec --ui tdd --compilers wisp:$(WISP_MODULE)

loc:
	wc -l src/*

