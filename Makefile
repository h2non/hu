BROWSERIFY = node ./node_modules/browserify/bin/cmd.js
WISP = ./node_modules/wisp/bin/wisp.js
WISP_MODULE = ./node_modules/wisp/
MOCHA = ./node_modules/.bin/mocha
UGLIFYJS = ./node_modules/.bin/uglifyjs
BANNER = "/*! hu.js - v0.1.0 - MIT License - https://github.com/h2non/hu */"

default: all
all: test browser
browser: cleanbrowser test banner browserify uglify
compile: mkdir clean index string number type misc object array maths equality collection function
test: compile mocha

mkdir:
	mkdir -p lib

string:
	cat src/macros.wisp src/string.wisp | $(WISP) --no-map > ./lib/string.js

number:
	cat src/macros.wisp src/number.wisp | $(WISP) --no-map > ./lib/number.js

type:
	cat src/macros.wisp src/type.wisp | $(WISP) --no-map > ./lib/type.js

object:
	cat src/macros.wisp src/object.wisp | $(WISP) --no-map > ./lib/object.js

array:
	cat src/macros.wisp src/array.wisp | $(WISP) --no-map > ./lib/array.js

maths:
	cat src/macros.wisp src/maths.wisp | $(WISP) --no-map > ./lib/maths.js

collection:
	cat src/macros.wisp src/collection.wisp | $(WISP) --no-map > ./lib/collection.js

function:
	cat src/macros.wisp src/function.wisp | $(WISP) --no-map > ./lib/function.js

equality:
	cat src/macros.wisp src/equality.wisp | $(WISP) --no-map > ./lib/equality.js

misc:
	cat src/macros.wisp src/misc.wisp | $(WISP) --no-map > ./lib/misc.js

index:
	cat src/hu.wisp | $(WISP) --no-map > ./lib/hu.js

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

mocha:
	$(MOCHA) --reporter spec --ui tdd --compilers wisp:$(WISP_MODULE)

loc:
	wc -l src/*

release:
	@$(call release, patch)

release-minor:
	@$(call release, minor)

publish:
	git push --tags origin HEAD:master
	npm publish
