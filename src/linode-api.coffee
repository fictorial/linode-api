request = require 'request'
qs = require 'querystring'
fs = require 'fs'

api_defs = JSON.parse fs.readFileSync __dirname + '/../data/api.json'

class LinodeClient
  constructor: (@api_key) ->
    @base_uri = "https://api.linode.com/?api_key=#{@api_key}"

  # Invoke a Linode API action with given arguments object.
  # Callback is a Function that takes (error, response).
  # See http://www.linode.com/api/ for API details.
  # Example:
  # c = new LinodeClient api_key
  # c.call 'test.echo', {msg: 'hello'}, (err, res) -> console.log res

  call: (action, args, callback) ->
    uri = "#{@base_uri}&api_action=#{action}&#{qs.stringify args}"
    request {uri}, (err, res, body) ->
      obj = JSON.parse body
      if obj.ERRORARRAY && obj.ERRORARRAY.length > 0
        callback obj.ERRORARRAY[0].ERRORMESSAGE, undefined
      else
        callback undefined, obj.DATA

exports.LinodeClient = LinodeClient

exports.dump_api = ->
  s = ""
  for method, params of api_defs
    s += "#{method}\n"
    for param in params
      s += "  #{param.param} #{if param.required then '(required)' else '(optional)'}\n"
    s += "\n"
  s
