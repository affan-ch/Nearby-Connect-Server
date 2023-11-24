const DeviceModel = require("../models/device_model");

class DeviceServices {
  static async addDevice(devicename, devicetype, userid) {
    try {
      console.log(
        "-----Device Information-----",
        devicename,
        devicetype,
        userid
      );

      const createDevice = new DeviceModel({
        devicename,
        devicetype,
        userid,
      });
      return await createDevice.save();
    } catch (err) {
      throw err;
    }
  }

  static async getDeviceByDevicename(devicename) {
    try {
      return await DeviceModel.findOne({ devicename });
    } catch (err) {
      console.log(err);
    }
  }
}

module.exports = DeviceServices;
