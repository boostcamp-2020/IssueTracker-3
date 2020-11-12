import express from "express";
import authController from "@controllers/auth";
import userController from "@controllers/user";
import auth from "@controllers/auth";

const router = express.Router();

router.get("/",authController.authCheck, authController.getUser);
router.post("/login", authController.login);

router.get("/github", authController.github);
router.get("/alluser", authController.getAllUser);
router.get("/github/callback", authController.github);
router.get("/github/loginFail", authController.githubLoginFail);
router.post("/github/token", authController.githubToken);
router.post("/github/web", authController.githubWeb);


router.post("/apple", authController.apple);

router.get("/logout", authController.logout);
router.post("/register", userController.add);

export = router;
