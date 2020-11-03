import { Request, Response } from "express";
import { User } from "@interfaces/user";
import UserModel from "@models/user";

const add = async (req: Request, res: Response): Promise<Response> => {
  const user: User = {
    id: null,
    login_id: req.body.userID,
    password: req.body.password,
    img: req.body?.img ?? "https://user-images.githubusercontent.com/5876149/97951341-39d26600-1ddd-11eb-94e7-9102b90bda8b.jpg",
    created_at: new Date(),
  };
  const result = await UserModel.insert(user, "USER");
  return res.json(result);
};

const find = async (userID: string, password: string): Promise<boolean> => {
  const rawPassword = password;
  const encrpytPassword = rawPassword;
  const result = await UserModel.findId( [userID, encrpytPassword ]);
  return result;
};
export default { find, add };
