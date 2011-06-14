# Linode API Client

A client for the [Linode API](http://www.linode.com/api/).

## API Key

Your API key can be found [here](https://manager.linode.com/profile/).

## Installation

    npm install linode-api

## Usage

````javascript
var client = new(require('linode-api').LinodeClient)(my_api_key);
client.call('test.echo', {msg: "hello, self!"}, function (err, res) {
  if (err) throw err;
  console.log("I said " + res + " to myself. Whee!");
});
````

## Updating the API

Should Linode update their API, we can auto-regenerate the API methods
by running 'make api'. Linode does not provide a machine-readable API
specification so this resorts to scraping their HTML documentation.

## Roadmap

- Add basic validation for required parameters (already parsed)

## Author

Brian Hammond <brian@fictorial.com> (http://fictorial.com)

## License

Copyright (c) 2011 Fictorial LLC.

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

