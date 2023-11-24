const TransferModel = require("../models/transfer_model");

class TransferServices {
  static async addTransfer(transferstatus, transfertype, timestamp, fileid) {
    try {
      console.log(
        "-----Transfer Information------",
        transferstatus,
        transfertype,
        timestamp,
        fileid
      );
      const createTransfer = new TransferModel({
        transferstatus,
        transfertype,
        timestamp,
        fileid,
      });
      return await createTransfer.save();
    } catch (err) {
      throw err;
    }
  }
}

module.exports = TransferServices;
