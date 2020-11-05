import db from "@providers/database";
import Model from "@models/model";
import { Event } from "@interfaces/event";
import HTTPCODE from "@root/magicnumber";

class EventModel extends Model {
  protected tableName: string;

  constructor() {
    super();
    this.tableName = "EVENT";
  }

  async select<T>(pData: T): Promise<Array<Event>> {
    try {
      const result = await db.query<T>(`SELECT * FROM ${this.tableName} WHERE issue_id = ?`, pData);
      this.data = [...result[0]];
      return this.data;
    } catch (err) {
      console.error(err);
      throw err;
    }
  }

  async add(pData: Event): Promise<number> {
    try {
      this.data = await super.insert(pData, this.tableName);
      return this.data ? HTTPCODE.SUCCESS : HTTPCODE.FAIL;
    } catch {
      return HTTPCODE.SERVER_ERR;
    }
  }
}

export default new EventModel();
