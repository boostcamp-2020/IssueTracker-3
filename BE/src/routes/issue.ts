import express, { Request, Response, NextFunction } from "express";
import IssueController from "@controllers/issue";

const router = express.Router();

router.get("/", IssueController.get);
router.post("/", IssueController.add);
router.patch("/", IssueController.edit);
router.get("/statechange/:id", (req: Request, res: Response, next: NextFunction) => {
  res.send("issue State Change");
});
export = router;
