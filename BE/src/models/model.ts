import db from "../providers/database";

export default class Model {
  static async insert<T>(pData: T, pTableName: string): Promise<number> {
    const data = await db.query<T>(`INSERT INTO ${pTableName} SET ?`, pData);
    const { insertId } = data[0];
    return insertId;
  }

  static async update<T>(pData: T, pTableName: string): Promise<number> {
    const id = Object.entries(pData)[0][1];
    const result = await db.query<Array<any>>(`UPDATE ${pTableName} SET ? WHERE id = ?`, [pData, id]);
    const { affectedRow } = result[0];
    return affectedRow;
  }

  static async delete(id: number, pTableName: string): Promise<number> {
    const result = await db.query<number>(`DELETE FROM ${pTableName} WHERE id = ?`, id);
    const { affectedRow } = result[0];
    return affectedRow;
  }
}
