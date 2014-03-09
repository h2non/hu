BROWSERIFY = node ./node_modules/browserify/bin/cmd.js
WISP = ./node_modules/wisp/bin/wisp.js

all: node browser
compile: string common object array
test: compile test

string: 
					cat src/string.wisp | $(WISP) --no-map > ./lib/string.js

common: 
					cat src/common.wisp | $(WISP) --no-map > ./lib/common.js

object: 
					cat src/object.wisp | $(WISP) --no-map > ./lib/object.js

array: 
					cat src/array.wisp | $(WISP) --no-map > ./lib/array.js

browser: browser
	$(BROWSERIFY) --debug \
    --exports require \
    --entry ./hu.js > ./hu.js

clean:
	rm -rf lib/*
	rm *.js