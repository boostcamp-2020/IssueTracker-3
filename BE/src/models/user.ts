import Model from "@models/model";
import db from "@providers/database";
import { User } from "@interfaces/user";

class UserModel extends Model {
  protected tableName: string;

  constructor() {
    super();
    this.tableName = "USER";
  }

  async select<T>(pData: T): Promise<boolean> {
    try {
      const result = await db.query<T>(`SELECT * FROM USER WHERE login_id = ? AND password = ?`, pData);
      this.data = [...result[0]];
      return true;
    } catch (err) {
      console.error(err);
      return false;
    }
  }

  async addUser(pData: User): Promise<number> {
    this.data = await super.insert(pData, this.tableName);
    return this.data;
  }
}

const user = new UserModel();
export default user;
