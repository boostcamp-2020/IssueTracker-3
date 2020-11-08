/* eslint-disable no-await-in-loop */
/* eslint-disable no-restricted-syntax */
import { Request, Response } from "express";
import AssigneeModel from "@models/assignee";
import { Assignee } from "@interfaces/assignee";
import HTTPCODE from "@utils/magicnumber";

const get = async (req: Request, res: Response): Promise<Response> => {
  try {
    const result = await AssigneeModel.select(+req.params.issueid);
    return res.json(result);
  } catch {
    return res.sendStatus(HTTPCODE.SERVER_ERR);
  }
};

const edit = async (req: Request, res: Response): Promise<Response> => {
  try {
    const data = await AssigneeModel.select(+req.params.issueid);
    const ids = data.map((value) => Number(value.id));
    for (const id of ids) {
      const result = await AssigneeModel.del(id);
      if (result === HTTPCODE.FAIL) return res.sendStatus(result);
      if (result === HTTPCODE.SERVER_ERR) return res.sendStatus(result);
    }
    const issueId = Number(req.params.issueid);
    const assignees = req.body.assignees.map((value: number) => {
      const assignee: Assignee = {
        id: null,
        issue_id: issueId,
        user_id: value,
      };
      return assignee;
    });

    for (const assignee of assignees) {
      const result = await AssigneeModel.add(assignee);
      if (result === HTTPCODE.FAIL) return res.sendStatus(result);
      if (result === HTTPCODE.SERVER_ERR) return res.sendStatus(result);
    }
    return res.sendStatus(HTTPCODE.SUCCESS);
  } catch {
    return res.sendStatus(HTTPCODE.SERVER_ERR);
  }
};

export default { get, edit };
