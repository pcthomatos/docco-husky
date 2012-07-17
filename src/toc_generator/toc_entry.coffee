class TOCEntry
  constructor: (name, protocol, indentSymbol, level) ->
    @name = name
    @protocol = protocol
    @url = ""
    @level = level
    @indentation = ""
    @indentSymbol = indentSymbol

  isFile: () ->
    @name.indexOf(".") > 0

  setIndentation: () ->
    counter = 0
    while counter < @level
      @indentation + @indentSymbol
      counter++
    return null

  toString: ()->
    "#{@indentation} [#{@name}](#{@url})\n"
  