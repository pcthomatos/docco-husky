Utilities = require('util')
TOCEntityFactory = require('./toc_entity_factory')

class TOCBuilder
  constructor: (resource, tempDirName, ioFacadeInstance)->
    @ioFacade= ioFacadeInstance
    @resources = resource || new Array()
    @tempDirName = tempDirName
    @EntityFactory = TOCEntityFactory.Singleton.get()

  generateTOC: ()->
    @createTableStructure()
    @writeToBuffer()
    @saveToFile()

  buildTempDir: (directoryName)->
    @ioFacade.buildDir(directoryName)

  saveToFile: (filePath = 'tmp/toc.md', buffer = '', callback = new Function)->
    @ioFacade.writeBufferToFile(filePath, buffer, callback)

  sortDescriptors: (descriptorsArray) ->
    files = new Array
    directories = new Array
    entities = {}
    for entity in descriptorsArray
      if entity.indexof(".") > 0
        files.push(entity)
      else
        directories.push(entity)
    entities.files = file
    entities.directories = directories
    return entities

  createTableStructure: (descriptorsArray = new Array) ->
   entities = @sortDescriptors descriptorsArray
   for entity in entities



module.exports = TOCBuilder
