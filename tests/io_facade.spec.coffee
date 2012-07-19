IOFacade = require("../src/toc_generator/io_facade")
Utilities = require("util")
Path = require("path")
FileSystem = require("fs")

describe "IOFacade", ->
  ioFacadeInstance = new IOFacade()
  testDir = "tmp"
  describe "when #buildDir is called with a string representing a path", ->
    it "should build a directory at the given path", ->

      ioFacadeInstance.buildDir testDir
      FileSystem.lstatSync(testDir).isDirectory().should.equal true
      FileSystem.rmdirSync testDir

  describe "when #dirDoesExis is called with a string representing a given directory", ->
    it "should return true if it exists on the file system or false if it does not", ->

      ioFacadeInstance.buildDir testDir
      ioFacadeInstance.dirDoesExist(testDir).should.equal true
      FileSystem.rmdirSync testDir

  describe "when #buildNormalizedFilePath is called with a path to a dir and a file name", ->
    it "should return the fully qualified file descriptor pointing at the file in that path", ->

      fileName = "test.txt"
      path = testDir + "/" + fileName
      expectedPath = Path.resolve(path)
      fileDescriptor = ioFacadeInstance.buildNormalizedFilePath(testDir, fileName)
      (fileDescriptor is expectedPath).should.equal true

  describe "when #writeBufferToFile is called with a file descriptor and a string buffer", ->
    it "should write the string buffer to the file descriptor", ->

      stringBuffer = "Blah Blah Blah Blah"
      fileDescriptor = "tmp/test.txt"
      ioFacadeInstance.buildDir testDir
      ioFacadeInstance.writeBufferToFile fileDescriptor, stringBuffer
      stats = FileSystem.lstatSync(fileDescriptor)
      stats.isFile().should.equal true
      (stats.size > 0).should.equal true
      FileSystem.unlinkSync fileDescriptor
      FileSystem.rmdirSync testDir

  describe "when #rmRecursive with string representing the path pointing to an empty directory", ->
    it "should remove that directory", ->

      ioFacadeInstance.buildDir testDir
      FileSystem.existsSync(testDir).should.equal true
      ioFacadeInstance.rmRecursive testDir
      FileSystem.existsSync(testDir).should.equal false

  describe "when #rmRecursive is called with a string represting a path to a non-empty directory", ->
    it "should delete all files within the directory and the directory itself", ->

      fileArray = [ "file1.txt", "file2.txt", "file3.txt" ]
      buffer = "blah Blah"
      ioFacadeInstance.buildDir testDir

      i = 0
      while i < fileArray.length
        fileDescriptor = testDir + "/" + fileArray[i]
        ioFacadeInstance.writeBufferToFile fileDescriptor, buffer
        i++

      FileSystem.existsSync(testDir).should.equal true
      filesOnSystem = FileSystem.readdirSync(testDir)
      (fileArray.length is filesOnSystem.length).should.equal true
      ioFacadeInstance.rmRecursive testDir
      FileSystem.existsSync(testDir).should.equal false
