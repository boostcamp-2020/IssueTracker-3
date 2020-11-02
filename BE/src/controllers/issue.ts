import { Request, Response } from "express";
import IssueModel from "@models/issue";
import { Issue } from "@interfaces/issue";

const get = async (req: Request, res: Response): Promise<any> => {
  const result = await IssueModel.select();
  return res.json(result);
};

export default { get };
