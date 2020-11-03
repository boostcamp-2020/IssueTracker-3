/* eslint-disable no-await-in-loop */
/* eslint-disable no-restricted-syntax */
import { Request, Response } from "express";
import TagModel from "@models/tag";
import { Tag } from "@interfaces/tag";

const get = async (req: Request, res: Response): Promise<Response> => {
  const result = await TagModel.select(+req.params.issue_id);
  return res.json(result);
};

const edit = async (req: Request, res: Response): Promise<Response> => {
  const data = await TagModel.select(+req.params.issue_id);
  const ids = data.map((value) => Number(value.id));
  for (const id of ids) {
    try {
      await TagModel.del(id);
    } catch (err) {
      return res.sendStatus(400);
    }
  }
  const issueId = Number(req.params.issueid);
  const objs = req.body.tags.map((value: number) => {
    const tag: Tag = {
      id: null,
      issue_id: issueId,
      label_id: value,
    };
    return tag;
  });

  for (const assignee of objs) {
    try {
      await TagModel.add(assignee);
    } catch (err) {
      return res.sendStatus(400);
    }
  }

  return res.sendStatus(200);
};
export default { get, edit };
