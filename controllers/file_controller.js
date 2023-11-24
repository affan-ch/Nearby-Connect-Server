const FileServices = require("../services/file_services");

exports.add = async (req, res, next) => {
  try {
    console.log("---req body---", req.body);
    const {
      filename,
      filepath,
      filetype,
      filesize,
      timestamp,
      senderuserid,
      recieveruserid,
    } = req.body;

    const response = await FileServices.addFile(
      filename,
      filepath,
      filetype,
      filesize,
      timestamp,
      senderuserid,
      recieveruserid
    );

    res.json({ status: true, success: "File Added successfully" });
  } catch (err) {
    console.log("---> err -->", err);
    next(err);
  }
};
