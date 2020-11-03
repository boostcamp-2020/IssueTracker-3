import express, { Request, Response, NextFunction } from "express";
import IssueController from "@controllers/issue";

const router = express.Router();

router.get("/", IssueController.get);
router.get("/:id", (req: Request, res: Response, next: NextFunction) => {
  res.send("issue single get");
});
router.post("/", IssueController.add);
router.patch("/", (req: Request, res: Response, next: NextFunction) => {
  res.send("issue patch");
});
router.get("/statechange/:id", (req: Request, res: Response, next: NextFunction) => {
  res.send("issue State Change");
});
export = router;
