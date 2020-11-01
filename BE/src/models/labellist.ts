import db from "../providers/database";
import Model from "./model";
import { LabelList } from "../interfaces/labellist";

export default class LabelListModel extends Model {
  static async read(pLabelListName: string, pTableName: string): promise<LabelList> {
    const data = await db.query(`SELECT * FROM ${pTableName} WHERE name = ?`, pLabelListName);
    const LabelListData: LabelList = data[0][0];
    return LabelListData;
  }
}
