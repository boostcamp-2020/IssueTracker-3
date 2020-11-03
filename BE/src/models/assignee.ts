import db from "@providers/database";
import Model from "@models/model";
import { Assignee } from "@interfaces/assignee";

class AssigneeModel extends Model {
  protected tableName: string;

  constructor() {
    super();
    this.tableName = "ASSIGNEE";
  }

  async select<T>(pId: T): Promise<Array<Assignee>> {
    try {
      const result = await db.query<T>(
        `
      select a.id, u.login_id, u.img 
      from ${this.tableName} a 
      join USER u on a.user_id = u.id
      where a.issue_id = ?`,
        pId
      );
      this.data = [...result[0]];
      return this.data;
    } catch (err) {
      console.error(err);
      return err;
    }
  }

  async add(pData: Assignee): Promise<number> {
    this.data = await super.insert(pData, this.tableName);
    return this.data;
  }

  async del(id: number): Promise<number> {
    this.data = await super.delete(id, this.tableName);
    return this.data;
  }
}

export default new AssigneeModel();
