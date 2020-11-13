import express, { Request, Response, NextFunction } from "express";
import authController from "@controllers/auth";
const router = express.Router();

router.get("/", authController.authCheck, (req: Request, res: Response, next: NextFunction) => {
  res.send("world");
});

export = router;
