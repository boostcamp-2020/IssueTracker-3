import db from "../providers/database";
import Model from "./model";
import { Milestone } from "../interfaces/milestone";

class MilestoneModel extends Model {
  type: string;

  constructor() {
    super();
    this.type = "MILESTONE";
  }

  async select(): Promise<Milestone> {
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
    this.data = await super.insert(pData, this.type);
    return this.data;
  }

  async edit(pData: Milestone): Promise<number> {
    this.data = await super.update(pData, this.type);
    return this.data;
  }

  async del(pData: number): Promise<number> {
    this.data = await super.delete(pData, this.type);
    return this.data;
  }
}

export default new MilestoneModel();
