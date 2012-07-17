var IOFacade, Utilities, Path, FileSystem;
IOFacade = require('../src/toc_generator/io_facade');
Utilities = require('util');
Path = require('path');
FileSystem = require('fs');

describe('IOFacade', function(){
  var ioFacadeInstance = new IOFacade();
  var testDir = "tmp";
  describe('when #buildDir is called with a string representing a path', function(){
    it('should build a directory at the given path', function(){

      ioFacadeInstance.buildDir(testDir);
      FileSystem.lstatSync(testDir).isDirectory().should.equal(true);

      // Clean-up
      FileSystem.rmdirSync(testDir);
    });
  });

  describe("when #dirDoesExis is called with a string representing a given directory", function(){
    it("should return true if it exists on the file system or false if it does not", function(){

      ioFacadeInstance.buildDir(testDir);
      ioFacadeInstance.dirDoesExist(testDir).should.equal(true)

      // Clean-up
      FileSystem.rmdirSync(testDir);
    });
  });

  describe("when #buildNormalizedFilePath is called with a path to a dir and a file name", function(){
    it("should return the fully qualified file descriptor pointing at the file in that path", function(){
      var fileName, path, expectedPath, fileDescriptor;

      fileName = "test.txt";
      path = testDir + "/" + fileName;
      expectedPath = Path.resolve(path);

      fileDescriptor = ioFacadeInstance.buildNormalizedFilePath(testDir, fileName);
      (fileDescriptor === expectedPath).should.equal(true);

    });
  });

  describe("when #writeBufferToFile is called with a file descriptor and a string buffer", function(){
    it("should write the string buffer to the file descriptor", function(){
      var stringBuffer, fileDescriptor, stats;
      stringBuffer = "Blah Blah Blah Blah";
      fileDescriptor = "tmp/test.txt";

      ioFacadeInstance.buildDir(testDir)
      ioFacadeInstance.writeBufferToFile(fileDescriptor, stringBuffer);

      stats = FileSystem.lstatSync(fileDescriptor);

      stats.isFile().should.equal(true);
      (stats.size > 0).should.equal(true);

      // Clean-up
      FileSystem.unlinkSync(fileDescriptor);
      FileSystem.rmdirSync(testDir);

    });
  });

  describe("when #rmRecursive with string representing the path pointing to an empty directory", function(){
    it("should remove that directory", function(){
      ioFacadeInstance.buildDir(testDir);
      Path.existsSync(testDir).should.equal(true);
      ioFacadeInstance.rmRecursive(testDir);
      Path.existsSync(testDir).should.equal(false);
    })
  });


  describe("when #rmRecursive is called with a string represting a path to a non-empty directory", function(){
    it("should delete all files within the directory and the directory itself", function(){
      var fileArray, buffer, fileDescriptor, i, filesOnSystem;

      fileArray = ["file1.txt", "file2.txt", "file3.txt"];
      buffer = "blah Blah";

      ioFacadeInstance.buildDir(testDir);

      for(i = 0; i < fileArray.length; i++){
        fileDescriptor = testDir + "/" + fileArray[i];
        ioFacadeInstance.writeBufferToFile(fileDescriptor, buffer);
      }

      Path.existsSync(testDir).should.equal(true);
      filesOnSystem = FileSystem.readdirSync(testDir);
      (fileArray.length == filesOnSystem.length).should.equal(true)
      ioFacadeInstance.rmRecursive(testDir);
      Path.existsSync(testDir).should.equal(false);

    });
  });

});
