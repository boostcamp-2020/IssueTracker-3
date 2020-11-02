import { Request, Response } from "express";
import LabelModel from "@models/label";
import { Label } from "@interfaces/label";

const getLabel = async (req: Request, res: Response): Promise<any> => {
  const result = await LabelModel.get();
  return res.json(result);
};

const postLabel = async (req: Request, res: Response): Promise<any> => {
  const label: Label = { id: null, name: req.body.name, description: req.body.description, color: req.body.color, created_at: new Date() };
  const result = await LabelModel.add(label);
  return res.json(result);
};
