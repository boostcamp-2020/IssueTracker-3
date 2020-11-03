import { Request, Response } from "express";
import { Milestone } from "@interfaces/milestone";
import MilestoneModel from "@models/milestone";

const get = async (req: Request, res: Response): Promise<Response<any>> => {
  const result = await MilestoneModel.select();
  return res.json(result);
};

const add = async (req: Request, res: Response): Promise<Response> => {
  const milestone: Milestone = {
    id: null,
    name: req.body.name,
    description: req.body.description,
    due_date: req.body.dueDate,
    created_at: new Date(),
  };
  const result = await MilestoneModel.add(milestone);
  return res.json(result);
};

const edit = async (req: Request, res: Response): Promise<Response> => {
  const milestone: Milestone = {
    id: req.body.id,
    name: req.body.name,
    description: req.body.description,
    due_date: req.body.dueDate,
    created_at: new Date(),
  };
  const result = await MilestoneModel.edit(milestone);
  return res.json(result);
};

const del = async (req: Request, res: Response): Promise<Response> => {
  const { id } = req.body;
  const result = await MilestoneModel.del(id);
  return res.json(result);
};
export default { get, add, edit, del };
