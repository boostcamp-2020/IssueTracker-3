import express, { Request, Response, NextFunction } from "express";

const router = express.Router();

router.get("/", (req: Request, res: Response, next: NextFunction) => {
  res.send("milestone get");
});
router.post("/", (req: Request, res: Response, next: NextFunction) => {
  res.send("milesone post");
});
router.patch("/", (req: Request, res: Response, next: NextFunction) => {
  res.send("milesone patch");
});
router.delete("/", (req: Request, res: Response, next: NextFunction) => {
  res.send("milesone delete");
});
export = router;
