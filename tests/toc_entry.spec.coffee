Utilities = require "util"
describe "A TOCEntry", ->
  TOCEntry = require '../src/toc_generator/toc_entry.coffee'

  tocEntryInstance = new TOCEntry "files/src/myFile.js"

  describe "when the constructor is called with file path", ->
    it "should create a new instance with properties set to those values", ->

      tocEntryInstance.name.should.equal("myFile.js")
      tocEntryInstance.filePath.should.equal('files/src/myFile.js')

  describe "when #export is called on a TOCEntry without any arguments", ->
    it "should return a string representation of itself", ->

      expected = "* [files/src/myFile.js](files/src/myFile.js.html)\n"
      actual = tocEntryInstance.export()
      actual.should.equal(expected)
