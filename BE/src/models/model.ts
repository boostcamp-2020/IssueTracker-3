import db from "../providers/database";

export default class Model {
  static async insert<T>(pData: T, pTableName: string): Promise<number> {
    const data = await db.query<T>(`INSERT INTO ${pTableName} SET ?`, pData);
    const { insertId } = data[0];
    return insertId;
  }
}
