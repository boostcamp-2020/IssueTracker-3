import express, { Request, Response, NextFunction } from "express";
import IssueController from "@controllers/issue";

const router = express.Router();

router.get("/", IssueController.get);
router.post("/", IssueController.add);
router.patch("/", IssueController.edit);
router.delete("/", IssueController.del);
router.patch("/:id/state/:state", IssueController.changeState);
export = router;
