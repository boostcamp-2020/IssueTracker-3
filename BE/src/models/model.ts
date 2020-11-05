import db from "@providers/database";

export default abstract class Model {
  data: any;

  protected abstract tableName: string;

  constructor() {
    this.data = 0;
  }

  async insert<T>(pData: T, pTableName: string): Promise<number> {
    try {
      const data = await db.query<T>(`INSERT INTO ${pTableName} SET ?`, pData);
      const { insertId } = data[0];
      this.data = insertId;
      return this.data;
    } catch (err) {
      console.error(err);
      throw err;
    }
  }

  async update<T>(pData: T, pTableName: string): Promise<number> {
    try {
      const id = Object.entries(pData)[0][1];
      const result = await db.query<Array<any>>(`UPDATE ${pTableName} SET ? WHERE id = ?`, [pData, id]);
      const { affectedRows } = result[0];
      this.data = affectedRows;
      return this.data;
    } catch (err) {
      console.error(err);
      throw err;
    }
  }

  async delete(id: number, pTableName: string): Promise<number> {
    try {
      const result = await db.query<number>(`DELETE FROM ${pTableName} WHERE id = ?`, id);
      const { affectedRows } = result[0];
      this.data = affectedRows;
      return this.data;
    } catch (err) {
      console.error(err);
      throw err;
    }
  }

  abstract async select<T>(pData: T): Promise<any>;
}
