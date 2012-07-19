FileSystem = require('fs')
Path = require('path')
Utilities = require('util')


# Class IOFacade:
#   Provides a simplified interface to Node.js File System IO library by
#   setting sensible defaults, validating user input, and concealing complex
#   underlying implimentations.
#
class IOFacade
  # constructor:
  # @params {Null}
  # @return {Object} returns a new instance of the IOFacade class.
  constructor: ()->

  # buildDir:
  #   Builds a file system directory at the path provided.
  # @param {String} directoryName A string value corresponding to the desired path of the directory
  # @return {Null} No return value

  buildDir: (directoryName)->
    path = Path.normalize(directoryName)
    if FileSystem.existsSync(path)
      @rmRecursive(path)
    FileSystem.mkdirSync(path)

  # dirDoesExist:
  #   Checks for the presence of a file at a specificied path.
  # @param {String} pathToDirectory is a string representation to the file path for which to be checked for a directory's presence
  # @return {Boolean} returns 'true' if the directory is present otherwise fale
  dirDoesExist: (pathToDirectory) ->
    if pathToDirectory
      path = Path.normalize(pathToDirectory)
      return FileSystem.existsSync(path)

  # buildNormalizedFilePath:
  #   Builds a normalized path for a given file at within a given path
  # @param {String} path is the path within which to include the file
  # @param {String} fileName is the string representation of the file name
  # @return {String} returns a fully qualified file descriptor.
  buildNormalizedFilePath: (path, fileName)->
    fileNameBase = Path.basename(fileName)
    fileDescriptor = Path.join(path, fileNameBase)
    return Path.resolve(fileDescriptor)

  # writeBufferToFile:
  #   Writes a given buffer to a given file descriptor and calls the povided callback method upon completetion.
  # @param {String} fileDescriptor corresponds to the file descriptor where the buffer will be written
  # @param {String} buffer is the string buffer to be written to the file descriptor
  # @param {Function} callback is the callback function to call once the buffer is written. The call back can accept three arguments, `(err, written, buffer)` 
  writeBufferToFile: (fileDescriptor, buffer, callback)->
    FileSystem.writeFileSync(fileDescriptor, buffer, 'utf8')

  # rmRecursive:
  #   Removies a directory on a given path along with all files and sub-directories within it.
  # @param {String} path is a string representing a path on the file system
  # @return {Null} Null return value
  rmRecursive: (path) ->
    path = path + "/"  if path[path.length - 1] isnt "/"
    files = FileSystem.readdirSync(path)
    filesLength = files.length
    if filesLength
      i = 0
      while i < filesLength
        file = files[i]
        fileStats = FileSystem.statSync(path + file)
        FileSystem.unlinkSync path + file  if fileStats.isFile()
        rmRecursive path + file  if fileStats.isDirectory()
        i += 1
    FileSystem.rmdirSync path

module.exports = IOFacade
