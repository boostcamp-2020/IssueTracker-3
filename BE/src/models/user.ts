import Model from "@models/model";
import db from "@providers/database";
import { User } from "@interfaces/user";

class UserModel extends Model {
  protected tableName: string;

  constructor() {
    super();
    this.tableName = "USER";
  }

  async select<T>(pData: T): Promise<User> {
    try {
      const result = await db.query<T>(`SELECT * FROM USER WHERE login_id = ?`, pData);
      this.data = [...result[0]];
      return this.data;
    } catch (err) {
      console.error(err);
      return err;
    }
  }

  async addUser(pData: User): Promise<number> {
    this.data = await super.insert(pData, this.tableName);
    return this.data;
  }
}

const user = new UserModel();
export default user;
