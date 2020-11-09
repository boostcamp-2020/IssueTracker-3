import { Label } from "@interfaces/label";
import Model from "@models/model";
import db from "@providers/database";
import HTTPCODE from "@utils/magicnumber";
import filter from "@utils/filter";
import makeResponse from "@utils/response";

class LabelModel extends Model {
  protected tableName: string;

  constructor() {
    super();
    this.tableName = "LABEL";
  }

  async select(): Promise<Array<Label>> {
    try {
      const data = await db.query(`select * from ${this.tableName}`);
      this.data = [...data[0].map(filter.nullFilter)];
      return this.data;
    } catch (err) {
      console.error(err);
      throw err;
    }
  }

  async add(pData: Label): Promise<any> {
    try {
      this.data = await super.insert<Label>(pData, `${this.tableName}`);
      return this.data ? makeResponse(HTTPCODE.SUCCESS, this.data) : makeResponse(HTTPCODE.FAIL, `fail insert`);
    } catch {
      return makeResponse(HTTPCODE.SERVER_ERR, `internal server error`);
    }
  }

  async edit(pData: object): Promise<number> {
    try {
      this.data = await super.update<object>(pData, `${this.tableName}`);
      return this.data ? HTTPCODE.SUCCESS : HTTPCODE.FAIL;
    } catch {
      return HTTPCODE.SERVER_ERR;
    }
  }

  async del(id: number): Promise<number> {
    try {
      this.data = await super.delete(id, `${this.tableName}`);
      return this.data ? HTTPCODE.SUCCESS : HTTPCODE.FAIL;
    } catch {
      return HTTPCODE.SERVER_ERR;
    }
  }
}

const labelModel = new LabelModel();
export default labelModel;
