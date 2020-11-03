import express from "express";
import controller from "@controllers/event";

const router = express.Router();

router.get("/:issueid", controller.get);
router.post("/:issueid", controller.add);
export = router;
