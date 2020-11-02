import { Request, Response } from "express";
import passport from "passport";
import jwt from "jsonwebtoken";
import dotenv from "dotenv";
import path from "path";

dotenv.config({ path: path.join(__dirname, "../../.env") });

function login(req: Request, res: Response): void {
  passport.authenticate("local", (err, userResult) => {
    if (err || !userResult) {
      return res.status(400).json({
        message: "Something is not right",
        user: userResult,
      });
    }
    req.login(userResult, (error) => {
      if (error) {
        return res.send(error);
      }
      const token = jwt.sign(JSON.parse(JSON.stringify(userResult)), String(process.env.JWT_SECRET), { expiresIn: "10m" });
      return res.json({ userResult, token });
    });
  })(req, res);
}
function logout(req: Request, res: Response): any {
  req.logout();
  return res.json({ state: "success" });
}
function githubLogin(req: Request, res: Response): any {
  console.log(req.user);
  return res.json({ state: "success" });
}
function githubLoginFail(req: Request, res: Response): any {
  return res.json({ state: "fail" });
}
const github = passport.authenticate("github", { failureRedirect: "/auth/github/loginFail" });
export default { login, logout, githubLogin, githubLoginFail, github };
