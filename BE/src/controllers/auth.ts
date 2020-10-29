import { Request, Response } from "express";
import passport from "passport";

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
      return res.json({ userResult });
    });
  })(req, res);
}
function githubLogin(req: Request, res: Response): any {
  return res.json({ state: "success" });
}
const github = passport.authenticate("github");
export default { login, githubLogin, github };
