#!/usr/bin/env coffee

# Linode API CLI interface
# Brian Hammond <brian@fictorial.com> https://github.com/fictorial/linode-api

{LinodeClient, dump_api} = require 'linode-api'
util = require 'util'

opts = (require 'optimist')
  .usage('Usage: linode-client [-k <api key>] <action> [param=value ...]')
  .string('k')

argv = opts.argv

action = argv._.shift()
api_key = argv.k or process.env['LINODE_API_KEY'] or ''

if api_key.length is 0 and action isnt 'user.getapikey'
  console.error 'no api key\n'
  opts.showHelp()
  process.exit 1

unless action?
  console.error 'nothing to do\n'
  opts.showHelp()
  console.error "<action> is one of the following:\n"
  console.error dump_api()
  process.exit 1

params = {}
for x in argv._
  [k,v] = x.split '='
  params[k] = v

client = new LinodeClient api_key

client.call action, params, (err, res) ->
  if err?
    console.error err.toString()
    process.exit 1
  console.log util.inspect res
