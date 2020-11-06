import express from "express";
import TagController from "../controllers/tag";

const router = express.Router();
router.get("/:issueid", TagController.get);
router.patch("/:issueid", TagController.edit);
export = router;
