import express, { Request, Response, NextFunction } from "express";

const router = express.Router();

router.get("/", (req: Request, res: Response, next: NextFunction) => {
  res.send("label get");
});
router.post("/", (req: Request, res: Response, next: NextFunction) => {
  res.send("label post");
});
router.patch("/", (req: Request, res: Response, next: NextFunction) => {
  res.send("label patch");
});
router.delete("/", (req: Request, res: Response, next: NextFunction) => {
  res.send("label delete");
});
export = router;
