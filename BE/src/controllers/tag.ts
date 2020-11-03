import { Request, Response } from "express";
import TagModel from "@models/tag";

const add = async (req: Request, res: Response): Promise<Response> => {
  const tag = { id: null, issue_id: req.body.issueId, label_id: req.body.labelId };
  const result = await TagModel.add(tag);
  return res.json(result);
};

export default { add };
