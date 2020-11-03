/* eslint-disable no-await-in-loop */
/* eslint-disable no-restricted-syntax */
import { Request, Response } from "express";
import AssigneeModel from "@models/assignee";
import { Assignee } from "@interfaces/assignee";

const get = async (req: Request, res: Response): Promise<Response> => {
  const result = await AssigneeModel.select(+req.params.issueid);
  return res.json(result);
};

const edit = async (req: Request, res: Response): Promise<Response> => {
  const data = await AssigneeModel.select(+req.params.issueid);
  const ids = data.map((value) => Number(value.id));
  for (const id of ids) {
    try {
      await AssigneeModel.del(id);
    } catch (err) {
      return res.sendStatus(400);
    }
  }
  const issueId = Number(req.params.issueid);
  const objs = req.body.assignees.map((value: number) => {
    const assignee: Assignee = {
      id: null,
      issue_id: issueId,
      user_id: value,
    };
    return assignee;
  });

  for (const assignee of objs) {
    try {
      await AssigneeModel.add(assignee);
    } catch (err) {
      return res.sendStatus(400);
    }
  }

  return res.sendStatus(200);
};

export default { get, edit };
