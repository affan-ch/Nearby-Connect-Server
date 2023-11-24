const router = require("express").Router();

const DeviceController = require("../controllers/device_controller");

router.post("/addDevice", DeviceController.addDevice);

module.exports = router;
