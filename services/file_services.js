const FileModel = require("../models/file_model");

class FileServices {
  static async addFile(filename,filepath,filetype,filesize,timestamp,senderuserid,recieveruserid) 
  {
    try {
      console.log(
        "-----File Information------",
        filename,
        filepath,
        filetype,
        filesize,
        timestamp,
        senderuserid,
        recieveruserid
      );
      const createFile = new FileModel({
        filename,
        filepath,
        filetype,
        filesize,
        timestamp,
        senderuserid,
        recieveruserid,
      });
      return await createFile.save();
    } 
    catch (err) 
    {
      throw err;
    }
  }
}

module.exports = FileServices;
