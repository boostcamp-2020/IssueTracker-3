import db from "@providers/database";
import { Tag } from "@interfaces/tag";
import Model from "@models/model";

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
      return err;
    }
  }

  async add(pData: Tag): Promise<number> {
    const result = await super.insert(pData, this.tableName);
    return result;
  }

  async del(id: number): Promise<number> {
    const result = await super.delete(id, this.tableName);
    return result;
  }
}

export default new TagModel();
