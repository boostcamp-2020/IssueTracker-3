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
      throw err;
    }
  }

  async add(pData: User): Promise<number> {
    try {
      this.data = await super.insert(pData, this.tableName);
      return this.data;
    } catch (err) {
      console.error(err);
      throw err;
    }
  }
}

const user = new UserModel();
export default user;
