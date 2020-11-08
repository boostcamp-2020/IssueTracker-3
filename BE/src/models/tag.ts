import db from "@providers/database";
import { Tag } from "@interfaces/tag";
import Model from "@models/model";
import HTTPCODE from "@utils/magicnumber";

class TagModel extends Model {
  protected tableName: string;

  constructor() {
    super();
    this.tableName = "TAG";
  }

  async select<T>(pId: T): Promise<Array<Tag>> {
    try {
      const result = await db.query<T>(
        `
        select t.id, l.name, l.color
        from ${this.tableName} t 
        join LABEL l on t.label_id = l.id
        where t.issue_id = ?`,
        pId
      );
      this.data = [...result[0]];
      return this.data;
    } catch (err) {
      console.error(err);
      throw err;
    }
  }

  async add(pData: Tag): Promise<number> {
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

export default new TagModel();
