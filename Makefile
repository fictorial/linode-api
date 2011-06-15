all: lib test

lib:
	coffee -c -o lib src/linode-api.coffee

bin:
	coffee -c -o bin src/linode-client.coffee
	@( echo "#!/usr/bin/env node"; cat bin/linode-client.js ) >.tmp$$
	@mv .tmp$$ bin/linode-client.js
	chmod +x bin/linode-client.js

api:
	tools/generate-api.coffee

test:
	nodeunit test/test.coffee

npm: lib test bin
	npm publish .

clean:
	rm -rf bin api

.PHONY: all lib npm clean api test bin
