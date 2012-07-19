TOCEntryFactory = require '../src/toc_generator/toc_entry_factory.coffee'
TOCEntry = require '../src/toc_generator/toc_entry.coffee'
describe "TOCEntryFactory.Singleton", ->

  describe "when #get is called the first time", ->
    it "should return a new, singleton instance of this class", ->

      singleton1 = TOCEntryFactory.Singleton.get()
      singleton2 = TOCEntryFactory.Singleton.get()
      expect(singleton1).to.be.a 'object'
      expect(singleton2).to.deep.equal singleton1

  describe "when #buildTOCEntry is called on a TOCEntryFactory singleton", ->
    it "returns a new instance of TOCEntry", ->
      singleton = TOCEntryFactory.Singleton.get()
      tocEntry = singleton.buildTOCEntry("/var/bar/baz.js")
      expect(tocEntry).to.be.instanceof(TOCEntry)
