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
router.post("/register", (req: Request, res: Response, next: NextFunction) => {
  const user: User = {
    id: null,
    login_id: req.body.userID,
    password: req.body.password,
    img: "img1",
    created_at: new Date(),
  };
  UserModel.insert(user, "USER");
});

router.patch("/register", (req: Request, res: Response, next: NextFunction) => {
  const user: User = {
    id: req.body.id,
    login_id: req.body.userID,
    password: req.body.password,
    img: "img2",
    created_at: new Date(),
  };
  UserModel.update(user, "USER");
});

router.delete("/register", (req: Request, res: Response, next: NextFunction) => {
  const { id } = req.body;
  const nid = Number(id);
  UserModel.delete(nid, "USER");
});

router.get("/users", (req: Request, res: Response, next: NextFunction) => {
  res.send("users");
});

export = router;
