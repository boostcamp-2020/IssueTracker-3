import { Request, Response } from "express";
import LabelModel from "@models/label";
import { Label } from "@interfaces/label";

const get = async (req: Request, res: Response): Promise<any> => {
  const result = await LabelModel.select();
  return res.json(result);
};

const add = async (req: Request, res: Response): Promise<any> => {
  const label: Label = { id: null, name: req.body.name, description: req.body.description, color: req.body.color, created_at: new Date() };
  const result = await LabelModel.add(label);
  return res.json(result);
};
const edit = async (req: Request, res: Response): Promise<any> => {
  const label: Label = {
    id: req.body.id,
    name: req.body.name,
    description: req.body.description,
    color: req.body.color,
    created_at: new Date(),
  };
  const result = await LabelModel.edit(label);
  return res.json(result);
};

const del = async (req: Request, res: Response): Promise<any> => {
  const { id } = req.body;
  const result = await LabelModel.del(id);
  return res.json(result);
};

export default { get, add, edit, del };
