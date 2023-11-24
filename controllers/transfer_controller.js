const TransferServices = require("../services/transfer_services");

exports.addTransfer = async (req, res, next) => {
  try {
    console.log("---req body---", req.body);
    const { transferstatus, transfertype, timestamp, fileid } = req.body;

    const response = await TransferServices.addTransfer(
      transferstatus,
      transfertype,
      timestamp,
      fileid
    );

    res.json({ status: true, success: "Transfer Added successfully" });
  } catch (err) {
    console.log("---> err -->", err);
    next(err);
  }
};
