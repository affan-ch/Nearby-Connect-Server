const db = require("../utils/db");
const mongoose = require("mongoose");
const { Schema } = mongoose;

const transferSchema = new Schema(
  {
    transferstatus: {
      type: String,
      required: [true, "Transfer Status name can not be empty"],
    },
    transfertype: {
      type: String,
      required: [true, "Transfer Type can not be empty"],
    },
    timestamp: {
      type: Date,
      required: [true, "Timestamp can not be empty"],
    },
    fileid: {
      type: Number,
      required: [true, "File id can not be empty"],
    },
    
  },
  { timestamps: true }
);
const TransferModel = db.model("transfer", transferSchema);
module.exports = TransferModel;
