/* eslint-disable no-restricted-syntax */
/* eslint-disable guard-for-in */
/* eslint-disable no-await-in-loop */
import db from "@providers/database";
import Model from "@models/model";
import { Issue } from "@interfaces/issue";
import HTTPCODE from "@utils/magicnumber";
import filter from "@utils/filter";
import makeResponse from "@utils/response";

class IssueModel extends Model {
	protected tableName: string;

	constructor() {
		super();
		this.tableName = "ISSUE";
	}

	async select<T>(): Promise<any> {
		try {
			const data = await db.query(`SELECT * from ${this.tableName}`);
			const issues = [...data[0]];
			for (const idx in issues) {
				const element = issues[idx];
				const tags = await db.query(`SELECT * from TAG t JOIN LABEL l ON t.label_id = l.id WHERE t.issue_id = ${element.id}`);
				issues[idx].labels = [...tags[0].map(filter.nullFilter)];
				const assignees = await db.query(`SELECT * from ASSIGNEE a JOIN USER u ON a.user_id = u.id where  a.issue_id= ${element.id}`);
				issues[idx].assignee = [...assignees[0].map(filter.nullFilter)];
				const milestones = await db.query(`SELECT * from MILESTONE m WHERE m.id = ${element.milestone_id}`);
				issues[idx].milestone = [...milestones[0].map(filter.nullFilter)];
				const comments = await db.query(`SELECT c.id, c.body, c.emoji, c.created_at, c.issue_id, c.user_id, u.login_id, u.img from COMMENT c JOIN USER u ON c.user_id = u.id WHERE issue_id = ${element.id}`);
				const comment = {
comments: [...comments[0].map(filter.nullFilter)],
		  counts: comments[0].length,
				};
				issues[idx].comment = comment;
			}
			issues.map(filter.nullFilter);
			return issues;
		} catch (err) {
			console.error(err);
			throw err;
		}
	}

	async add(pData: Issue): Promise<any> {
		try {
			this.data = await super.insert(pData, this.tableName);
			return this.data ? makeResponse(HTTPCODE.SUCCESS, this.data) : makeResponse(HTTPCODE.SUCCESS, `fail insert`);
		} catch {
			return makeResponse(HTTPCODE.SUCCESS, `internal server error`);
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

	async editMilestone(pData: object, milestoneId: number): Promise<number> {
		try {
			this.data = await db.query(`UPDATE ${this.tableName} SET ? WHERE milestone_id = ?`, [pData, milestoneId]);
			return this.data[0].affectedRows ? HTTPCODE.SUCCESS : HTTPCODE.FAIL;
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
