const db = require("../utils/db");
const mongoose = require("mongoose");
const { Schema } = mongoose;

const fileSchema = new Schema(
  {
    filename: {
      type: String,
      required: [true, "File name can not be empty"],
    },
    filepath: {
      type: String,
      required: [true, "File path can not be empty"],
    },
    filetype: {
      type: String,
      required: [true, "File type can not be empty"],
    },
    filesize: {
      type: Number,
      required: [true, "File size can not be empty"],
    },
    timestamp: {
      type: Date,
      required: [true, "Timestamp can not be empty"],
    },
    senderuserid: {
      type: Number,
      required: [true, "Sender User id can not be empty"],
    },
    recieveruserid: {
      type: Number,
      required: [true, "Reciever User id can not be empty"],
    },
  },
  { timestamps: true }
);
const FileModel = db.model("file", fileSchema);
module.exports = FileModel;
