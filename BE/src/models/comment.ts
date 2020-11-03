import db from "@providers/database";
import Model from "@models/model";
import { Comment } from "@interfaces/comment";

class CommentModel extends Model {
  protected tableName: string;

  constructor() {
    super();
    this.tableName = "COMMENT";
  }

  async select<T>(id: T): Promise<any> {
    const data = await db.query(`
    SELECT c.id, c.body, c.created_at, c.emoji , u.login_id, u.img 
    FROM ${this.tableName} c 
    JOIN USER u on c.user_id = u.id
    WHERE c.issue_id = ${id}`);
    return data[0];
  }

  async add(pData: Comment): Promise<any> {
    const insertId = await super.insert(pData, this.tableName);
    return insertId;
  }

  async edit(pData: object): Promise<any> {
    const affectedId = await super.update(pData, this.tableName);
    return affectedId;
  }

  async del(id: number): Promise<any> {
    const affectedId = await super.delete(id, this.tableName);
    return affectedId;
  }
}

export default new CommentModel();
