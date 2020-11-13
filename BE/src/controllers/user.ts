import { Request, Response } from "express";
import { User } from "@interfaces/user";
import UserModel from "@models/user";

const add = async (req: Request, res: Response): Promise<Response> => {
  const user: User = {
    id: null,
    login_id: req.body.user_id,
    password: req.body.password,
    img: req.body?.img ?? "https://user-images.githubusercontent.com/5876149/97951341-39d26600-1ddd-11eb-94e7-9102b90bda8b.jpg",
    created_at: new Date(),
  };
  try {
    await UserModel.add(user);
    return res.status(201).json({ status: "success" });
  } catch {
    return res.status(400).json({ status: "fail" });
  }
};

const find = async (userID: string, password: string): Promise<boolean> => {
  const rawPassword = password;
  const encrpytPassword = rawPassword;
  try {
    const result = await UserModel.select([userID, encrpytPassword]);
    return result;
  } catch (err) {
    return false;
  }
};
export default { find, add };
