import express, { Request, Response, NextFunction } from "express";

const router = express.Router();

router.post("/login", (req: Request, res: Response, next: NextFunction) => {
  res.send("login");
});
router.get("/logout", (req: Request, res: Response, next: NextFunction) => {
  res.send("logout");
});
router.post("/register", (req: Request, res: Response, next: NextFunction) => {
  res.send("register");
});

export = router;
