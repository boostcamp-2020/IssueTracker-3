/* eslint-disable no-restricted-syntax */
/* eslint-disable guard-for-in */
/* eslint-disable no-await-in-loop */
import db from "@providers/database";
import Model from "@models/model";
import { Issue } from "@interfaces/issue";
import HTTPCODE from "@utils/magicnumber";

class IssueModel extends Model {
  protected tableName: string;

  constructor() {
    super();
    this.tableName = "ISSUE";
  }

  async select<T>(): Promise<any> {
    try {
      const data = await db.query(`select * from ${this.tableName}`);
      const issues = [...data[0]];
      for (const idx in issues) {
        const element = issues[idx];
        const tags = await db.query(`select * from TAG t join LABEL l on t.label_id = l.id where t.issue_id = ${element.id}`);
        issues[idx].labels = [...tags[0]];
        const assignees = await db.query(`select * from ASSIGNEE a join USER u on a.user_id = u.id where  a.issue_id= ${element.id}`);
        issues[idx].assignee = [...assignees[0]];
        const milestones = await db.query(`select * from MILESTONE m where m.id = ${element.milestone_id}`);
        issues[idx].milestone = [...milestones[0]];
      }
      return issues;
    } catch (err) {
      console.error(err);
      throw err;
    }
  }

  async add(pData: Issue): Promise<number> {
    try {
      this.data = await super.insert(pData, this.tableName);
      return this.data ? HTTPCODE.SUCCESS : HTTPCODE.FAIL;
    } catch {
      return HTTPCODE.SERVER_ERR;
    }
  }

  async edit(pData: object): Promise<number> {
    try {
      this.data = await super.update(pData, this.tableName);
      return this.data ? HTTPCODE.SUCCESS : HTTPCODE.FAIL;
    } catch {
      return HTTPCODE.SERVER_ERR;
    }
  }

  async del(id: number): Promise<number> {
    try {
      this.data = await super.delete(id, this.tableName);
      return this.data ? HTTPCODE.SUCCESS : HTTPCODE.FAIL;
    } catch {
      return HTTPCODE.SERVER_ERR;
    }
  }

  async changeState(id: number, state: boolean): Promise<number> {
    const data = { id, state };
    try {
      this.data = await super.update(data, this.tableName);
      return this.data ? HTTPCODE.SUCCESS : HTTPCODE.FAIL;
    } catch {
      return HTTPCODE.SERVER_ERR;
    }
  }
}
export default new IssueModel();
