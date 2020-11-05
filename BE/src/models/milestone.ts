import db from "@providers/database";
import Model from "@models/model";
import { Milestone } from "@interfaces/milestone";
import HTTPCODE from "@root/magicnumber";

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
      throw err;
    }
  }

  async add(pData: Milestone): Promise<number> {
    try {
      this.data = await super.insert(pData, this.tableName);
      return this.data ? HTTPCODE.SUCCESS : HTTPCODE.FAIL;
    } catch {
      return HTTPCODE.SERVER_ERR;
    }
  }

  async edit(pData: object): Promise<number> {
    try {
      this.data = await super.update(pData, this.tableName);
      return this.data ? HTTPCODE.SUCCESS : HTTPCODE.FAIL;
    } catch {
      return HTTPCODE.SERVER_ERR;
    }
  }

  async del(pData: number): Promise<number> {
    try {
      this.data = await super.delete(pData, this.tableName);
      return this.data ? HTTPCODE.SUCCESS : HTTPCODE.FAIL;
    } catch {
      return HTTPCODE.SERVER_ERR;
    }
  }

  async changeState(id: number, state: boolean): Promise<number> {
    const data = { id, state };
    try {
      this.data = await super.update(data, this.tableName);
      return this.data ? HTTPCODE.SUCCESS : HTTPCODE.FAIL;
    } catch {
      return HTTPCODE.SERVER_ERR;
    }
  }
}

export default new MilestoneModel();
