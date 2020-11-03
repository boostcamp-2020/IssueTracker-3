import { Request, Response } from "express";
import IssueModel from "@models/issue";
import { Issue } from "@interfaces/issue";
import { json } from "body-parser";

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

export default { get, add };
