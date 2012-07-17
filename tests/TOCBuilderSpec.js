var TOCBuilder, IOFacade, helper, Utilities, Path, FileSystem;

TOCBuilder = require('../src/toc_generator/toc_builder');
IOFacade = require('../src/toc_generator/io_facade');
Utilities = require('util');
Path = require('path');
FileSystem = require('fs');


describe('TOCBuilder', function(){
  var tocBuilder, tmpDirPath, filePath;

  beforeEach(function(){
    var docTargets, ioFacadeInstance;

      docTargets = ['app.js', 'up.js', 'customConfig.js', 'lib', 'script'];
      tmpDirPath = "temp";

      ioFacadeInstance = new IOFacade();
      tocBuilder = new TOCBuilder(docTargets, tmpDirPath, ioFacadeInstance);
  });

  describe('when #buildTempDir method is called with a path representing the temporary directory', function(){
    it("should create that directory on the file system", function(){

      tocBuilder.buildTempDir(tmpDirPath);

      Path.existsSync(tmpDirPath).should.equal(true)

      // Cleanup
      FileSystem.rmdirSync(tmpDirPath);

    });
  });

  describe('when #saveToFile method is called with a file name, a string buffer, and a callback method', function(){
    it("should write the string buffer to a file with the given file name and extension", function(){
      var fileName, filePath, fileExtension, stringBuffer, stats;

      stringBuffer = "* [testFile1](http://testfile1.js.html)\n* [testFile2(http://testfile2.html)]\n* [testFile3](http://testfile3.html)";

      fileName = 'test';
      fileExtension = '.md';
      filePath = tmpDirPath + '/' + fileName + fileExtension;

      tocBuilder.buildTempDir(tmpDirPath);
      tocBuilder.saveToFile(filePath, stringBuffer);

      stats = FileSystem.lstatSync(filePath);
      stats.isFile().should.equal(true);
      (stats.size > 0).should.equal(true);

      // Cleanup

      FileSystem.unlinkSync(filePath);
      FileSystem.rmdirSync(tmpDirPath);
    });
  });

});
