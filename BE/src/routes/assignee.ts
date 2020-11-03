import express from "express";
import CommentController from "@controllers/comment";

const router = express.Router();

router.get("/:issueid", CommentController.get);
router.patch("/:issueid", CommentController.edit);
export = router;
