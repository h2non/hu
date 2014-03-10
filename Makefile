BROWSERIFY = node ./node_modules/browserify/bin/cmd.js
WISP = ./node_modules/wisp/bin/wisp.js
WISP_MODULE = ./node_modules/wisp/
MOCHA = ./node_modules/.bin/mocha
UGLIFYJS = ./node_modules/.bin/uglifyjs
FLAGS = --verbose

default: all
all: test browser
browser: browserify uglify
compile: clean index string common object array
test: compile cleantest runtest

string:
	cat src/string.wisp | $(WISP) --no-map > ./lib/string.js

common:
	cat src/common.wisp | $(WISP) --no-map > ./lib/common.js

object:
	cat src/object.wisp | $(WISP) --no-map > ./lib/object.js

array:
	cat src/array.wisp | $(WISP) --no-map > ./lib/array.js

index:
	cat src/hu.wisp | $(WISP) --no-map > ./lib/hu.js

browserify:
	$(BROWSERIFY) --debug \
		--exports require \
		--standalone \
		--entry ./lib/hu.js > ./hu.js

uglify:
	$(UGLIFYJS) hu.js --mangle > hu.min.js

clean:
	rm -rf lib/*
	rm -f *.js

cleantest:
	rm -f test/*.js

runtest:
	$(MOCHA) --reporter spec --ui tdd --compilers wisp:$(WISP_MODULE)

loc:
	wc -l src/*

