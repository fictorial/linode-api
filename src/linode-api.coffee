request = require 'request'
qs = require 'querystring'
fs = require 'fs'

api_defs = JSON.parse fs.readFileSync __dirname + '/../data/api.json'

errors =
  0: 'ok'
  1: 'Bad request'
  2: 'No action was requested'
  3: 'The requested class does not exist'
  4: 'Authentication failed'
  5: 'Object not found'
  6: 'A required property is missing for this action'
  7: 'Property is invalid'
  8: 'A data validation error has occurred'
  9: 'Method Not Implemented'
  10: 'Too many batched requests'
  11: 'RequestArray isn\'t valid JSON or WDDX'
  12: 'Batch approaching timeout. Stopping here.'
  13: 'Permission denied'
  30: 'Charging the credit card failed'
  31: 'Credit card is expired'
  40: 'Limit of Linodes added per hour reached'
  41: 'Linode must have no disks before delete'

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
      if obj.ERRORARRAY.length > 0
        callback errors[obj.ERRORARRAY[0]], undefined
      else
        callback undefined, obj.DATA

exports.LinodeClient = LinodeClient
