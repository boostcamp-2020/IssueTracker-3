import { Request, Response } from "express";
import CommentModel from "@models/comment";

const get = async (req: Request, res: Response): Promise<Response> => {
  const result = await CommentModel.select(+req.params.issueId);
  return res.json(result);
};

export default { get };
