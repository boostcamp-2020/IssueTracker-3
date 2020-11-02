import db from "@providers/database";
import Model from "@models/model";
import { Milestone } from "@interfaces/milestone";

export default class MilestoneModel extends Model {
  static async read(pMilestoneName: string, pTableName: string): Promise<Milestone> {
    const data = await db.query(`SELECT * FROM ${pTableName} WHERE name = ?`, pMilestoneName);
    const milestoneData: Milestone = data[0][0];
    return milestoneData;
  }
}
