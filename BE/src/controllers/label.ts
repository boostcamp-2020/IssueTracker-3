import { Request, Response } from "express";
import LabelModel from "@models/label";
import { Label } from "@interfaces/label";

const getLabel = async (req: Request, res: Response): Promise<any> => {
  const result = await LabelModel.get();
  return res.json(result);
};
