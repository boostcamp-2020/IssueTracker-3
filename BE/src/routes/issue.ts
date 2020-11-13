import express, { Request, Response, NextFunction } from "express";
import IssueController from "@controllers/issue";
import authController from "@controllers/auth";

const router = express.Router();

router.get("/",authController.authCheck, IssueController.get);
router.post("/", IssueController.add);
router.patch("/", IssueController.edit);
router.delete("/", IssueController.del);
router.patch("/:id/state/:state", IssueController.changeState);

router.get("/filter/state/:state/author/:author/assignee/:assignee/comment/:comment", IssueController.getFilter);
export = router;
