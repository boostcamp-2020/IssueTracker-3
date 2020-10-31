import db from "../providers/database";
import Model from "./model";
import { User } from "../interfaces/user";

class UserModel extends Model {
  static async read(pLoginID: string, pTableName: string): Promise<User> {
    const data = await db.query(`SELECT * FROM ${pTableName} WHERE login_id = ?`, pLoginID);
    const userData: User = data[0][0];
    return userData;
  }
}

export default UserModel;
