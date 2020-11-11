import db from "@providers/database";
import Model from "@models/model";
import { Milestone } from "@interfaces/milestone";
import HTTPCODE from "@utils/magicnumber";
import filter from "@utils/filter";
import makeResponse from "@utils/response";

class MilestoneModel extends Model {
  protected tableName: string;

  constructor() {
    super();
    this.tableName = "MILESTONE";
  }

  async select(): Promise<Array<Milestone>> {
    try {
      const result = await db.query<Milestone>(`SELECT * FROM MILESTONE`);
      this.data = [...result[0].map(filter.nullFilter)];
      return this.data;
    } catch (err) {
      console.error(err);
      throw err;
    }
  }

  async add(pData: Milestone): Promise<any> {
    try {
      this.data = await super.insert(pData, this.tableName);
      return this.data ? makeResponse(HTTPCODE.SUCCESS, this.data) : makeResponse(HTTPCODE.FAIL, `fail insert`);
    } catch {
      return makeResponse(HTTPCODE.SERVER_ERR, `internal server error`);
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
    console.log(data);
    try {
      this.data = await super.update(data, this.tableName);
      console.log(this.data);
      return this.data ? HTTPCODE.SUCCESS : HTTPCODE.FAIL;
    } catch {
      return HTTPCODE.SERVER_ERR;
    }
  }
}

export default new MilestoneModel();
