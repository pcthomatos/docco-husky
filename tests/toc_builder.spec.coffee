TOCBuilder = require("../src/toc_generator/toc_builder")
IOFacade = require("../src/toc_generator/io_facade")
Utilities = require("util")
Path = require("path")
FileSystem = require("fs")

describe "TOCBuilder", ->
  tocBuilder = tmpDirPath = null

  beforeEach ->
    docTargets = [ "app.js", "up.js", "customConfig.js", "lib", "script" ]
    tmpDirPath = "temp"
    ioFacadeInstance = new IOFacade()
    tocBuilder = new TOCBuilder(docTargets, tmpDirPath, ioFacadeInstance)

  describe "when #buildTempDir method is called with a path representing the temporary directory", ->
    it "should create that directory on the file system", ->
      tocBuilder.buildTempDir tmpDirPath
      FileSystem.existsSync(tmpDirPath).should.equal true
      FileSystem.rmdirSync tmpDirPath

  describe "when #saveToFile method is called with a file name, a string buffer, and a callback method", ->
    it "should write the string buffer to a file with the given file name and extension", ->

      stringBuffer = "* [testFile1](http://testfile1.js.html)\n* [testFile2(http://testfile2.html)]\n* [testFile3](http://testfile3.html)"
      fileName = "test"
      fileExtension = ".md"
      filePath = tmpDirPath + "/" + fileName + fileExtension

      tocBuilder.buildTempDir tmpDirPath
      tocBuilder.saveToFile filePath, stringBuffer

      stats = FileSystem.lstatSync(filePath)
      stats.isFile().should.equal true
      (stats.size > 0).should.equal true
      FileSystem.unlinkSync filePath
      FileSystem.rmdirSync tmpDirPath
