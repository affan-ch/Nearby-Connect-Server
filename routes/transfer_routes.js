const router = require("express").Router();

const TransferController = require("../controllers/transfer_controller");

router.post("/addTransfer", TransferController.addTransfer);

module.exports = router;
