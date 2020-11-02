import { Label } from "@interfaces/label";
import Model from "@models/model";
import db from "@providers/database";

class LabelModel extends Model {
  protected tableName: string;

  constructor() {
    super();
    this.tableName = "LABEL";
  }

  async select(): Promise<Array<Label>> {
    const data = await db.query(`select name, description, color, created_at from ${this.tableName}`);
    const res: Array<Label> = [...data[0]];
    return res;
  }

  async add(pData: Label): Promise<number> {
    const insertId = await super.insert<Label>(pData, `${this.tableName}`);
    return insertId;
  }

  async edit(pData: Label): Promise<number> {
    const affecedId = await super.update<Label>(pData, `${this.tableName}`);
    return affecedId;
  }

  async del(id: number): Promise<number> {
    const affecedId = await super.delete(id, `${this.tableName}`);
    return affecedId;
  }
}

const labelModel = new LabelModel();
export default labelModel;
