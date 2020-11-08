import db from "@providers/database";
import Model from "@models/model";
import { Comment } from "@interfaces/comment";
import HTTPCODE from "@utils/magicnumber";

class CommentModel extends Model {
  protected tableName: string;

  constructor() {
    super();
    this.tableName = "COMMENT";
  }

  async select<T>(id: T): Promise<any> {
    try {
      const data = await db.query(`
      SELECT c.id, c.body, c.created_at, c.emoji , u.login_id, u.img 
      FROM ${this.tableName} c 
      JOIN USER u on c.user_id = u.id
      WHERE c.issue_id = ${id}`);
      this.data = [...data[0]];
      return this.data;
    } catch (err) {
      console.error(err);
      throw err;
    }
  }

  async add(pData: Comment): Promise<any> {
    try {
      this.data = await super.insert(pData, this.tableName);
      return this.data ? HTTPCODE.SUCCESS : HTTPCODE.FAIL;
    } catch {
      return HTTPCODE.SERVER_ERR;
    }
  }

  async edit(pData: object): Promise<any> {
    try {
      this.data = await super.update(pData, this.tableName);
      return this.data ? HTTPCODE.SUCCESS : HTTPCODE.FAIL;
    } catch {
      return HTTPCODE.SERVER_ERR;
    }
  }

  async del(id: number): Promise<any> {
    try {
      this.data = await super.delete(id, this.tableName);
      return this.data ? HTTPCODE.SUCCESS : HTTPCODE.FAIL;
    } catch {
      return HTTPCODE.SERVER_ERR;
    }
  }
}

export default new CommentModel();
