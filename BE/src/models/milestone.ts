import db from "@providers/database";
import Model from "@models/model";
import { Milestone } from "@interfaces/milestone";

class MilestoneModel extends Model {
  protected tableName: string;

  constructor() {
    super();
    this.tableName = "MILESTONE";
  }

  async select(): Promise<Array<Milestone>> {
    try {
      const result = await db.query<Milestone>(`SELECT * FROM MILESTONE`);
      this.data = [...result[0]];
      return this.data;
    } catch (err) {
      console.error(err);
      return err;
    }
  }

  async add(pData: Milestone): Promise<number> {
    this.data = await super.insert(pData, this.tableName);
    return this.data;
  }

  async edit(pData: Milestone): Promise<number> {
    this.data = await super.update(pData, this.tableName);
    return this.data;
  }

  async del(pData: number): Promise<number> {
    this.data = await super.delete(pData, this.tableName);
    return this.data;
  }
}

export default new MilestoneModel();
