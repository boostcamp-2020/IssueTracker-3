import { Request, Response } from "express";
import LabelModel from "@models/label";
import { Label } from "@interfaces/label";
import HTTPCODE from "@utils/magicnumber";

const get = async (req: Request, res: Response): Promise<any> => {
  try {
    const result = await LabelModel.select();
    return res.json(result);
  } catch {
    return res.sendStatus(HTTPCODE.SERVER_ERR);
  }
};

const add = async (req: Request, res: Response): Promise<any> => {
  const label: Label = {
    id: null,
    name: req.body.name,
    description: req.body?.description ?? null,
    color: req.body.color,
    created_at: new Date(),
  };
  const result = await LabelModel.add(label);
  return res.status(result.httpcode).json(result.message);
};
const edit = async (req: Request, res: Response): Promise<any> => {
  const label = {
    id: req.body.id,
    name: req.body.name,
    description: req.body?.description ?? null,
    color: req.body.color,
  };
  const result = await LabelModel.edit(label);
  return res.sendStatus(result);
};

const del = async (req: Request, res: Response): Promise<any> => {
  const { id } = req.body;
  const result = await LabelModel.del(id);
  return res.sendStatus(result);
};

export default { get, add, edit, del };
