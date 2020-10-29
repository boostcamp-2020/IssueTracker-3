import express, { Request, Response, NextFunction } from "express";
import authController from "../controllers/auth";

const router = express.Router();

router.post("/login", authController.login);

router.get("/logout", (req: Request, res: Response, next: NextFunction) => {
  res.send("logout");
});
router.post("/register", (req: Request, res: Response, next: NextFunction) => {
  res.send("register");
});
router.get("/users", (req: Request, res: Response, next: NextFunction) => {
  res.send("users");
});

export = router;
