TOCEntryFactory = exports ? this
TOCEntry = require('./toc_entry')

class TOCEntryFactory.Singleton
  _instance = undefined
  @get: (args)->
    _instance ?= new _Singleton(args)

class _Singleton
  constructor: (@args) ->
    return null

  instance: (name = "", protocol = "http", indentSymbol = "*", level = 0, instance)->
    instance = instance || new TOCEntry(name, protocol, indentSymbol, level)