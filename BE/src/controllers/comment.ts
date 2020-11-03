import { Request, Response } from "express";
import CommentModel from "@models/comment";
import { Comment } from "@interfaces/comment";

const get = async (req: Request, res: Response): Promise<Response> => {
  const result = await CommentModel.select(+req.params.issueid);
  return res.json(result);
};

const add = async (req: Request, res: Response): Promise<Response> => {
  const comment: Comment = {
    id: null,
    issue_id: req.body.issue_id,
    user_id: req.body.user_id,
    body: req.body.body,
    emoji: req.body.emoji,
    created_at: new Date(),
  };
  const result = await CommentModel.add(comment);
  return res.json(result);
};

const edit = async (req: Request, res: Response): Promise<Response> => {
  const comment = {
    id: req.body.id,
    issue_id: req.body.issueId,
    user_id: req.body.userId,
    body: req.body.body,
    emoji: req.body.emoji,
  };
  const result = await CommentModel.edit(comment);
  return res.json(result);
};

const del = async (req: Request, res: Response): Promise<Response> => {
  const result = await CommentModel.del(+req.body.id);
  return res.json(result);
};

export default { get, add, edit, del };
