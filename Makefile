BROWSERIFY = node ./node_modules/browserify/bin/cmd.js
WISP = ./node_modules/wisp/bin/wisp.js

all: browser
compile: clean string common object array
test: compile run-test

string:
	cat src/string.wisp | $(WISP) --no-map > ./lib/string.js

common:
	cat src/common.wisp | $(WISP) --no-map > ./lib/common.js

object:
	cat src/object.wisp | $(WISP) --no-map > ./lib/object.js

array:
	cat src/array.wisp | $(WISP) --no-map > ./lib/array.js

browser:
	$(BROWSERIFY) --debug \
    --exports require \
    --entry ./hu.js > ./hu.js

clean:
	rm -rf lib/*
	rm -f *.js

run-test: $(WISP) ./test/hu.wisp --verbose
