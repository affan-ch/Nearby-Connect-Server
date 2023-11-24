const db = require("../utils/db");
const mongoose = require("mongoose");
const { Schema } = mongoose;

const deviceSchema = new Schema(
  {
    devicename: {
      type: String,
      required: [true, "File name can not be empty"],
    },
    devicetype: {
      type: String,
      required: [true, "File path can not be empty"],
    },
    userid: {
      type: Number,
      required: [true, "File type can not be empty"],
    },
  },
  { timestamps: true }
);
const DeviceModel = db.model("device", deviceSchema);
module.exports = DeviceModel;
