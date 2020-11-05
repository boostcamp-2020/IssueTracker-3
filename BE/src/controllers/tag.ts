/* eslint-disable no-await-in-loop */
/* eslint-disable no-restricted-syntax */
import { Request, Response } from "express";
import TagModel from "@models/tag";
import { Tag } from "@interfaces/tag";
import HTTPCODE from "@root/magicnumber";

const get = async (req: Request, res: Response): Promise<Response> => {
  try {
    const result = await TagModel.select(+req.params.issueid);
    return res.json(result);
  } catch {
    return res.sendStatus(HTTPCODE.SERVER_ERR);
  }
};

const edit = async (req: Request, res: Response): Promise<Response> => {
  const data = await TagModel.select(+req.params.issueid);
  const ids = data.map((value) => Number(value.id));
  for (const id of ids) {
    const result = await TagModel.del(id);
    if (result === HTTPCODE.FAIL) return res.sendStatus(HTTPCODE.FAIL);
    if (result === HTTPCODE.SERVER_ERR) return res.sendStatus(HTTPCODE.SERVER_ERR);
  }
  const issueId = Number(req.params.issueid);
  const tags = req.body.tags.map((value: number) => {
    const tag: Tag = {
      id: null,
      issue_id: issueId,
      label_id: value,
    };
    return tag;
  });

  for (const tag of tags) {
    const result = await TagModel.add(tag);
    if (result === HTTPCODE.FAIL) return res.sendStatus(HTTPCODE.FAIL);
    if (result === HTTPCODE.SERVER_ERR) return res.sendStatus(HTTPCODE.SERVER_ERR);
  }

  return res.sendStatus(HTTPCODE.SUCCESS);
};
export default { get, edit };
