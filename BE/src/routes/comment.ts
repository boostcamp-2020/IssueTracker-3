import express, { Request, Response, NextFunction } from "express";
import CommentController from "@controllers/comment";

const router = express.Router();

router.get("/:issueId", CommentController.get);
router.post("/", (req: Request, res: Response, next: NextFunction) => {
  res.send("comment post");
});
router.patch("/", (req: Request, res: Response, next: NextFunction) => {
  res.send("comment patch");
});
router.delete("/", (req: Request, res: Response, next: NextFunction) => {
  res.send("comment delete");
});
export = router;
