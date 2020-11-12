import { Request, Response } from "express";
import { Milestone } from "@interfaces/milestone";
import MilestoneModel from "@models/milestone";
import IssueModel from "@models/issue";
import HTTPCODE from "@utils/magicnumber";

const get = async (req: Request, res: Response): Promise<Response<any>> => {
  try {
    const result = await MilestoneModel.select();
    return res.json(result);
  } catch {
    return res.sendStatus(HTTPCODE.SERVER_ERR);
  }
};

const add = async (req: Request, res: Response): Promise<Response> => {
  const milestone: Milestone = {
    id: null,
    name: req.body.name,
    description: req.body.description ?? null,
    state: true,
    due_date: req.body.due_date ?? null,
    created_at: new Date(),
  };
  const result = await MilestoneModel.add(milestone);
  return res.status(result.httpcode).json(result.message);
};

const edit = async (req: Request, res: Response): Promise<Response> => {
  const milestone = {
    id: req.body.id,
    name: req.body.name,
    description: req.body?.description ?? null,
    due_date: req.body?.due_date ?? null,
  };
  const result = await MilestoneModel.edit(milestone);
  return res.sendStatus(result);
};

const del = async (req: Request, res: Response): Promise<Response> => {
  const { id } = req.body;
  const issue = {
    milestone_id: null,
  };
  const issueRes = await IssueModel.editMilestone(issue, id);
  if (issueRes === HTTPCODE.SUCCESS) {
    const result = await MilestoneModel.del(id);
    return res.sendStatus(result);
  }
  return res.sendStatus(issueRes);
};

const changeState = async (req: Request, res: Response): Promise<Response> => {
  const result = await MilestoneModel.changeState(+req.params.id, !!+req.params.state);
  return res.sendStatus(result);
};
export default { get, add, edit, del, changeState };
