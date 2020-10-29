import express, { Request, Response, NextFunction } from "express";

const router = express.Router();

router.get("/", (req: Request, res: Response, next: NextFunction) => {
  res.send("issue total get");
});
router.get("/:id", (req: Request, res: Response, next: NextFunction) => {
  res.send("issue single get");
});
router.post("/", (req: Request, res: Response, next: NextFunction) => {
  res.send("issue post");
});
router.patch("/", (req: Request, res: Response, next: NextFunction) => {
  res.send("issue patch");
});
router.get("/statechange/:id", (req: Request, res: Response, next: NextFunction) => {
  res.send("issue State Change");
});
export = router;
