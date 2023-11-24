const router = require("express").Router();

const FileController = require("../controllers/file_controller");

router.post("/add", FileController.add);

module.exports = router;
