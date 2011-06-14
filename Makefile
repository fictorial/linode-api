all: compile test

compile:
	coffee -c -o lib src/linode-api.coffee

api:
	tools/generate-api.coffee

test:
	nodeunit test/test.coffee

npm: compile test
	npm publish .

clean:
	rm -rf bin api

.PHONY: all compile npm clean api test
