import { NextFunction, Request, Response } from "express";
import passport from "passport";
import jwt from "jsonwebtoken";
import dotenv from "dotenv";
import path from "path";
import axios from "axios";

import userController from "@controllers/user";
import { User } from "@interfaces/user";
import UserModel from "@models/user";

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

async function apple(req: Request, res: Response): Promise<Response> {
  const loginUser: any = req.body;
  const decoded: any = jwt.decode(loginUser.identity_token);
  const userEmail: string = decoded.email;
  const userResult = userEmail.split("@")[0];

  const loginId = userResult;
  let searchResult = await userController.find(loginId, loginId);
  console.log("serachResult : " + searchResult);
  if (searchResult) {
    console.log("go");
    req.login(userResult, (error) => {
      if (error) {
        return res.send(error);
      }
      const JWT = jwt.sign(JSON.parse(JSON.stringify(userResult)), String(process.env.JWT_SECRET), { expiresIn: "10m" });
      return res.json({ state: "success", JWT, id: searchResult });
    });
  } else {
    console.log("stop");
    const user: User = {
      id: null,
      login_id: userResult,
      password: userResult,
      img: req.body?.img ?? "https://user-images.githubusercontent.com/5876149/97951341-39d26600-1ddd-11eb-94e7-9102b90bda8b.jpg",
      created_at: new Date(),
      type: 2,
    }
    await UserModel.add(user);
    searchResult = await userController.find(loginId, loginId);
    console.log("stop : "+ searchResult);
  }

  const JWT = jwt.sign(JSON.parse(JSON.stringify(userResult)), String(process.env.JWT_SECRET), { expiresIn: "10m" });
  return res.json({ state: "success", JWT, id: searchResult});

  // 내일 확인
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
async function githubToken(req: Request, res: Response): Promise<Response<JSON>> {
  console.log("githubToken" + req.body.url );
  const code = req.body.url.split("?")[1].split("=")[1];
  console.log(code);
  // https://docs.github.com/en/free-pro-team@latest/developers/apps/authorizing-oauth-apps
  const access_token = await axios.post(`https://github.com/login/oauth/access_token`,{
    params: {
      client_id: process.env.GIT_ID,
      client_secret : process.env.GIT_PASSWORD,
      code : code,
    }
  });
  console.log(access_token);
  // POST https://github.com/login/oauth/access_token
  // access token 을 get 함

  const { data } = await axios.get("https://api.github.com/user",{
    headers: {
      'Authorization': `token ${access_token}` 
    }
  });
  const userName = data.login;
  // Authorization: token OAUTH-TOKEN
  // result = GET https://api.github.com/user
  // result.login
  console.log(userName);

  let searchResult = await userController.find(userName, userName);
  if (searchResult) {
    console.log("go");
    req.login(userName, (error) => {
      if (error) {
        return res.send(error);
      }
      const JWT = jwt.sign(JSON.parse(JSON.stringify(userName)), String(process.env.JWT_SECRET), { expiresIn: "10m" });
      return res.json({ state: "success", JWT, id: searchResult });
    });
  } else {
    console.log("stop");
    const user: User = {
      id: null,
      login_id: userName,
      password: userName,
      img: req.body?.img ?? "https://user-images.githubusercontent.com/5876149/97951341-39d26600-1ddd-11eb-94e7-9102b90bda8b.jpg",
      created_at: new Date(),
      type: 1,
    }
    await UserModel.add(user);
    searchResult = await userController.find(userName, userName);
    console.log("stop : "+ searchResult);
  }


  const JWT = jwt.sign(JSON.parse(JSON.stringify({ name:userName })), String(process.env.JWT_SECRET), { expiresIn: "10m" });
  return res.json({ state: "success", JWT, id :searchResult });
}
async function githubWeb(req: Request, res: Response): Promise<Response<JSON>> {
  const { code } = req.body;

  const access_token = await axios.post("https://github.com/login/oauth/access_token",{
    params: {
      client_id: process.env.GIT_ID,
      client_secret : process.env.GIT_PASSWORD,
      code : code,
    }
  });
  console.log(access_token);

  const { data } = await axios.get("https://api.github.com/user",{
    headers: {
      'Authorization': `token ${access_token}` 
    }
  });
  const userResult = data.login;
  const JWT = jwt.sign(JSON.parse(JSON.stringify({ userResult })), String(process.env.JWT_SECRET), { expiresIn: "10m" });
  return res.json({ state: "success", JWT });
}

function authCheck(req: Request, res: Response ,next: NextFunction){
  if (req.headers.authorization) {
    const token = req.headers.authorization.split('Bearer ')[1];

    jwt.verify(token, String(process.env.JWT_SECRET) , (err) => {
      if (err) {
        res.status(401).json({ error: 'Auth Error from authChecker' });
      } else {
        next();
      }
    });
  } else {
    res.status(401).json({ error: 'Auth Error from authChecker' });
  }
};
export default { login, logout, githubLogin, githubLoginFail, github, apple, getAllUser, githubToken, githubWeb ,authCheck};
