import express from "express";
import CommentController from "@controllers/comment";

const router = express.Router();

router.get("/:issueId", CommentController.get);
router.post("/", CommentController.add);
router.patch("/", CommentController.edit);
router.delete("/", CommentController.del);
export = router;
