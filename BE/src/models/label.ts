import { Label } from "@interfaces/label";
import Model from "@models/model";
import db from "@providers/database";
import HTTPCODE from "@utils/magicnumber";

class LabelModel extends Model {
  protected tableName: string;

  constructor() {
    super();
    this.tableName = "LABEL";
  }

  async select(): Promise<Array<Label>> {
    try {
      const data = await db.query(`select name, description, color, created_at from ${this.tableName}`);
      this.data = [...data[0]];
      return this.data;
    } catch (err) {
      console.error(err);
      throw err;
    }
  }

  async add(pData: Label): Promise<number> {
    try {
      this.data = await super.insert<Label>(pData, `${this.tableName}`);
      return this.data ? HTTPCODE.SUCCESS : HTTPCODE.FAIL;
    } catch {
      return HTTPCODE.SERVER_ERR;
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
