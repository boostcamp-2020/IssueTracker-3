import { User } from "./interface/user";

class UserModel {
  user: User;

  constructor(pLoginID: string, pPassword: string, pImg: string) {
    const date = new Date();
    this.user = {
      id: 0,
      loginID: pLoginID,
      password: pPassword,
      img: pImg,
      createdAt: date,
    };
  }
}
