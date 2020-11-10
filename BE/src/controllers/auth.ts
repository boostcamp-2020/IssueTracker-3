import { Request, Response } from "express";
import passport from "passport";
import jwt from "jsonwebtoken";
import dotenv from "dotenv";
import path from "path";

import userController from "@controllers/user";

dotenv.config({ path: path.join(__dirname, "../../.env") });

function login(req: Request, res: Response): void {
  passport.authenticate(
    "local",
    async (err, userResult): Promise<any> => {
      if (err || !userResult) {
        return res.status(400).json({
          message: "Something is not right",
        });
      }
      const loginId = userResult.userID;
      const rawPassword = userResult.password;
      const searchResult = await userController.find(loginId, rawPassword);
      if (searchResult) {
        req.login(userResult, (error) => {
          if (error) {
            return res.send(error);
          }
          const JWT = jwt.sign(JSON.parse(JSON.stringify(userResult)), String(process.env.JWT_SECRET), { expiresIn: "10m" });
          return res.json({ state: "success", JWT, id: searchResult });
        });
      } else {
        return res.json({ state: "fail" });
      }
    }
  )(req, res);
}

function githubLogin(req: Request, res: Response): Response<JSON> | Response<string> {
  const gitUser: any = req.user;
  const userResult = gitUser.profile.username;
  const JWT = jwt.sign(JSON.parse(JSON.stringify({ userResult })), String(process.env.JWT_SECRET), { expiresIn: "10m" });
  return res.json({ state: "success", JWT });
}

function apple(req: Request, res: Response): Response<JSON> | Response<string> {
  const loginUser: any = req.body;
  const decoded: any = jwt.decode(loginUser.identity_token);
  const userEmail: string = decoded.email;
  const userResult = userEmail.split("@")[0];
  const JWT = jwt.sign(JSON.parse(JSON.stringify({ userResult })), String(process.env.JWT_SECRET), { expiresIn: "10m" });
  return res.json({ state: "success", JWT });
}

function logout(req: Request, res: Response): Response<JSON> {
  req.logout();
  return res.json({ state: "success" });
}

function githubLoginFail(req: Request, res: Response): Response<JSON> {
  return res.json({ state: "fail" });
}
async function getAllUser(req: Request, res: Response): Promise<Response<JSON>> {
  const result = await userController.getAll();
  return res.json(result);
}
const github = passport.authenticate("github", { failureRedirect: "/auth/github/loginFail" });
export default { login, logout, githubLogin, githubLoginFail, github, apple, getAllUser };
