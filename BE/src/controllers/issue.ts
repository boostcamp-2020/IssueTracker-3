import { Request, Response } from "express";
import IssueModel from "@models/issue";
import { Issue } from "@interfaces/issue";
import HTTPCODE from "@root/magicnumber";

const get = async (req: Request, res: Response): Promise<any> => {
  try {
    const result = await IssueModel.select();
    return res.json(result);
  } catch {
    return res.sendStatus(HTTPCODE.SERVER_ERR);
  }
};

const add = async (req: Request, res: Response): Promise<any> => {
  const issue: Issue = {
    id: null,
    title: req.body.title,
    body: req.body.body,
    user_id: req.body.author,
    created_at: new Date(),
    closed_at: req.body?.closed_at ?? null,
    state: true,
    milestone_id: req.body?.milestone_at ?? null,
  };
  const result = await IssueModel.add(issue);
  return res.sendStatus(result);
};

const edit = async (req: Request, res: Response): Promise<any> => {
  const issue = {
    id: req.body.id,
    title: req.body.title,
    body: req.body.body,
    user_id: req.body.author,
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

export default { get, add, edit, del, changeState };
