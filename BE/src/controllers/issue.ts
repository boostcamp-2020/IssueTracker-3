import { Request, Response } from "express";
import IssueModel from "@models/issue";
import { Issue } from "@interfaces/issue";
import HTTPCODE from "@utils/magicnumber";
import filterFunc from "@utils/filter";

const get = async (req: Request, res: Response): Promise<any> => {
  try {
    const result = await IssueModel.select();
    return res.json(result);
  } catch {
    return res.sendStatus(HTTPCODE.SERVER_ERR);
  }
};

const getFilter = async (req: Request, res: Response): Promise<any> => {
  const { state = 1, author, assignee, comment } = req.body;
  try {
    const issues = await IssueModel.select();
    const issuesFilter = issues.filter((issue: any) => {
      if (state) if (!filterFunc.stateFilter(issue.state, state)) return false;
      if (author) if (!filterFunc.userFilter(issue.user_id, author)) return false;
      if (assignee) if (!filterFunc.assigneeFilter(issue.assignee, assignee)) return false;
      if (comment) if (!filterFunc.commentFilter(issue.comment.comments, comment)) return false;
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
    milestone_id: req.body?.milestone_at ?? null,
  };
  const result = await IssueModel.add(issue);
  return res.status(result.httpcode).json(result.message);
};

const edit = async (req: Request, res: Response): Promise<any> => {
  const issue = {
    id: req.body.id,
    title: req.body.title,
    body: req.body.body,
    user_id: req.body.user_id,
    closed_at: req.body?.closed_at ?? null,
    state: req.body.state,
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
