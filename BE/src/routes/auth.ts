import express, { Request, Response, NextFunction } from "express";
import authController from "../controllers/auth";
import UserModel from "../models/user";
import { User } from "../interfaces/user";

const router = express.Router();

router.post("/login", authController.login);

router.get("/github", authController.github);
router.get("/github/callback", authController.githubLogin);
router.get("/github/loginFail", authController.githubLoginFail);

router.get("/logout", authController.logout);
router.post("/register", async (req: Request, res: Response, next: NextFunction) => {
  const user: User = {
    id: null,
    login_id: req.body.userID,
    password: req.body.password,
    img: "img1",
    created_at: new Date(),
  };
  const result = await UserModel.insert(user, "USER");
  res.json(result);
});

export = router;
