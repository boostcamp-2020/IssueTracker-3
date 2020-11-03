import { Tag } from "@interfaces/tag";
import Model from "@models/model";

class TagModel extends Model {
  protected tableName: string;

  constructor() {
    super();
    this.tableName = "TAG";
  }

  select<T>(pData: T): Promise<any> {
    return new Promise((resolve, reject) => {
      resolve(this.tableName);
    });
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
