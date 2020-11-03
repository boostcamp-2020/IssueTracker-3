import { Request, Response } from "express";
import passport from "passport";
import jwt from "jsonwebtoken";
import dotenv from "dotenv";
import path from "path";

dotenv.config({ path: path.join(__dirname, "../../.env") });

function login(req: Request, res: Response): void {
  passport.authenticate("local", (err, userResult): Response<JSON> | Response<string> | undefined => {
    if (err || !userResult) {
      return res.status(400).json({
        message: "Something is not right",
      });
    }
    req.login(userResult, (error) => {
      if (error) {
        return res.send(error);
      }
      const JWT = jwt.sign(JSON.parse(JSON.stringify(userResult)), String(process.env.JWT_SECRET), { expiresIn: "10m" });
      return res.json({ state: "success", JWT });
    });
  })(req, res);
}
function apple(req: Request, res: Response): Response<JSON> | Response<string> {
  const userResult = req.body.profile.username;
  const JWT = jwt.sign(JSON.parse(JSON.stringify(userResult)), String(process.env.JWT_SECRET), { expiresIn: "10m" });
  return res.json({ state: "success", JWT });
}
function githubLogin(req: Request, res: Response): Response<JSON> | Response<string> {
  const loginUser: any = req.user;
  console.log(loginUser);
  const decoded: any = jwt.decode(loginUser.identity_token);
  console.log(decoded);
  const userEmail: string = decoded.payload.email;
  console.log(userEmail);
  const userResult = userEmail.split("@")[0];
  console.log(userResult);
  const JWT = jwt.sign(JSON.parse(JSON.stringify(userResult)), String(process.env.JWT_SECRET), { expiresIn: "10m" });
  return res.json({ state: "success", JWT });
}

function logout(req: Request, res: Response): Response<JSON> {
  req.logout();
  return res.json({ state: "success" });
}
function githubLoginFail(req: Request, res: Response): Response<JSON> {
  return res.json({ state: "fail" });
}
const github = passport.authenticate("github", { failureRedirect: "/auth/github/loginFail" });
export default { login, logout, githubLogin, githubLoginFail, github, apple };
