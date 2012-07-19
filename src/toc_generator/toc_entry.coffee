class TOCEntry
  constructor: (filePath) ->
    @filePath = filePath
    @setName()
    @setUrl()

  setName: ->
    pattern = /[a-z]+\.{1}[a-z]+$/im
    results  = @filePath.match(pattern)
    @name = results[0]

  setUrl: ->
    @url = "#{@filePath}.html"

  export: ->
    "* [#{@filePath}](#{@url})\n"


module.exports = TOCEntry
