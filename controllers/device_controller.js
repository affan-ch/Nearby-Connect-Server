const DeviceServices = require("../services/device_services");

exports.addDevice = async (req, res, next) => {
  try {
    console.log("---req body---", req.body);
    const { devicename, devicetype, userid } = req.body;

    const response = await DeviceServices.addDevice(devicename, devicetype, userid);

    res.json({ status: true, success: "Device Added successfully" });
  } catch (err) {
    console.log("---> err -->", err);
    next(err);
  }
};
