import { Label } from "@interfaces/label";
import { User } from "@interfaces/user";
import Model from "@models/model";
import db from "@providers/database";

class LabelModel extends Model {
  tableName: string;

  constructor() {
    super();
    this.tableName = "LABEL";
  }

  async get(): Promise<Array<Label>> {
    const res: Array<Label> = [];
    const data = await db.query(`select name, description, color, created_at from ${this.tableName}`);
    data[0].forEach((labelData: any) => {
      const label: Label = labelData;
      res.push(label);
    });
    return res;
  }

  async add(pData: Label): Promise<number> {
    const insertId = await super.insert<Label>(pData, `${this.tableName}`);
    return insertId;
  }

}

const labelModel = new LabelModel();
export default labelModel;
