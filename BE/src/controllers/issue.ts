import { Request, Response } from "express";
import IssueModel from "@models/issue";
import { Issue } from "@interfaces/issue";
import HTTPCODE from "@utils/magicnumber";
import filterFunc from "@utils/filter";
import { Tag } from "@interfaces/tag";
import TagModel from "@models/tag";

const get = async (req: Request, res: Response): Promise<any> => {
  try {
    const result = await IssueModel.select();
    return res.json(result);
  } catch {
    return res.sendStatus(HTTPCODE.SERVER_ERR);
  }
};

const getFilter = async (req: Request, res: Response): Promise<any> => {
  const { state, author, assignee, comment } = req.params;
  try {
    const issues = await IssueModel.select();
    const issuesFilter = issues.filter((issue: any) => {
	  if (!filterFunc.stateFilter(!!issue.state, !!+state)) return false;
      if (+author) if (!filterFunc.userFilter(issue.user_id, +author)) return false;
      if (+assignee) if (!filterFunc.assigneeFilter(issue.assignee, +assignee)) return false;
      if (+comment) if (!filterFunc.commentFilter(issue.comment.comments, +comment)) return false;
      return true;
    });
    res.json(issuesFilter);
  } catch (err) {
    console.error(err);
    return res.sendStatus(HTTPCODE.SERVER_ERR);
  }
};

const add = async (req: Request, res: Response): Promise<any> => {

  const issue: Issue = {
    id: null,
    title: req.body.title,
    body: req.body.body,
    user_id: req.body.user_id,
    created_at: new Date(),
    closed_at: req.body?.closed_at ?? null,
    state: true,
    milestone_id: req.body?.milestone_id ?? null,
  };

  let result = await IssueModel.add(issue);
  if (result.httpcode === HTTPCODE.FAIL || result.httpcode === HTTPCODE.SERVER_ERR) return res.status(result.httpcode).json(result.message);
  if (req.body.labelids.length > 0) {
    const tags = req.body.labelids.map((value: number) => {
      const tag: Tag = {
        id: null,
        issue_id: result.message,
        label_id: value,
      };
      return tag;
    });
    for (const tag of tags) {
      result = await TagModel.add(tag);
      if (result === HTTPCODE.FAIL) return res.status(HTTPCODE.FAIL).json(`FAIL TO INSERT TAG`);
      if (result === HTTPCODE.SERVER_ERR) return res.status(HTTPCODE.SERVER_ERR).json(`internal server error`);
    }
  }
  return res.status(HTTPCODE.SUCCESS).json(`success insert issue`);
};

const edit = async (req: Request, res: Response): Promise<any> => {
  const issue = {
    id: req.body.id,
    title: req.body.title,
    body: req.body.body,
    user_id: req.body.user_id,
    closed_at: req.body?.closed_at ?? null,
    milestone_id: req.body?.milestone_id ?? null,
  };
  const result = await IssueModel.edit(issue);
  return res.sendStatus(result);
};

const del = async (req: Request, res: Response): Promise<any> => {
  const result = await IssueModel.del(req.body.id);
  return res.sendStatus(result);
};

const changeState = async (req: Request, res: Response): Promise<any> => {
  const result = await IssueModel.changeState(+req.params.id, !!+req.params.state);
  return res.sendStatus(result);
};

export default { get, getFilter, add, edit, del, changeState };
