import express from "express";
import authController from "@controllers/auth";

const router = express.Router();

router.post("/login", authController.login);

router.get("/github", authController.github);
router.get("/github/callback", authController.github, authController.githubLogin);
router.get("/github/loginFail", authController.githubLoginFail);

router.post("/apple", authController.apple);

router.get("/logout", authController.logout);
router.post("/register", authController.register);

export = router;
