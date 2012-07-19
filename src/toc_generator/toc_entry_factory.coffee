TOCEntryFactory= exports ? this # http://stackoverflow.com/questions/4214731/coffeescript-global-variables
TOCEntry = require('./toc_entry')

# The publicly accessible Singleton fetcher
class TOCEntryFactory.Singleton
  _instance = undefined # Must be declared here to force the closure on the class

  @get: (args) -> # Must be a static method
    _instance ?= new _Singleton args

# The actual Singleton class
class _Singleton
  constructor: (@args) ->

  buildTOCEntry: (filePath)->
    new TOCEntry filePath
