import express from "express";
import assigneeController from "@controllers/assignee";

const router = express.Router();

router.get("/:issueid", assigneeController.get);
router.patch("/:issueid", assigneeController.edit);
export = router;
