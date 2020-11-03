import { Request, Response } from "express";
import IssueModel from "@models/issue";
import { Issue } from "@interfaces/issue";

const get = async (req: Request, res: Response): Promise<any> => {
  const result = await IssueModel.select();
  return res.json(result);
};

const add = async (req: Request, res: Response): Promise<any> => {
  const issue: Issue = {
    id: null,
    title: req.body.title,
    body: req.body.body,
    user_id: req.body.author,
    created_at: new Date(),
    closed_at: req.body?.closedAt ?? null,
    state: true,
    milestone_id: req.body?.milestoneId ?? null,
  };
  const result = await IssueModel.add(issue);
  return res.json(result);
};

const edit = async (req: Request, res: Response): Promise<any> => {
  const issue: Issue = {
    id: req.body.id,
    title: req.body.title,
    body: req.body.body,
    user_id: req.body.author,
    created_at: req.body.createdAt,
    closed_at: req.body?.closedAt ?? null,
    state: req.body.state,
    milestone_id: req.body?.milestoneId ?? null,
  };
  const result = await IssueModel.edit(issue);
  return res.json(result);
};

const del = async (req: Request, res: Response): Promise<any> => {
  const result = await IssueModel.del(req.body.id);
  return res.json(result);
};

const changeState = async (req: Request, res: Response): Promise<any> => {
  const result = await IssueModel.changeState(+req.params.id, !!req.params.state);
  return res.json(result);
};

export default { get, add, edit, del, changeState };
