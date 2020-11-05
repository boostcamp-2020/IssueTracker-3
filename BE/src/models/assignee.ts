import db from "@providers/database";
import Model from "@models/model";
import { Assignee } from "@interfaces/assignee";
import HTTPCODE from "@root/magicnumber";

class AssigneeModel extends Model {
  protected tableName: string;

  constructor() {
    super();
    this.tableName = "ASSIGNEE";
  }

  async select<T>(pId: T): Promise<Array<Assignee>> {
    try {
      const data = await db.query<T>(
        `
      select a.id, u.login_id, u.img 
      from ${this.tableName} a 
      join USER u on a.user_id = u.id
      where a.issue_id = ?`,
        pId
      );
      this.data = [...data[0]];
      return this.data;
    } catch (err) {
      console.error(err);
      throw err;
    }
  }

  async add(pData: Assignee): Promise<number> {
    try {
      this.data = await super.insert(pData, this.tableName);
      return this.data ? this.data : HTTPCODE.FAIL;
    } catch {
      return HTTPCODE.SERVER_ERR;
    }
  }

  async del(id: number): Promise<number> {
    try {
      this.data = await super.delete(id, this.tableName);
      return this.data ? HTTPCODE.SUCCESS : HTTPCODE.FAIL;
    } catch {
      return HTTPCODE.SERVER_ERR;
    }
  }
}

export default new AssigneeModel();
