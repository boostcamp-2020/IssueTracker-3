import express from "express";
import authController from "@controllers/auth";
import userController from "@controllers/user";

const router = express.Router();

router.post("/login", authController.login);

router.get("/github", authController.github);
router.get("/alluser", authController.getAllUser);
router.get("/github/callback", authController.github, authController.githubLogin);
router.get("/github/loginFail", authController.githubLoginFail);
router.post("/github/token", authController.githubToken);
router.get("/github/web", authController.githubWeb);


router.post("/apple", authController.apple);

router.get("/logout", authController.logout);
router.post("/register", userController.add);

export = router;
