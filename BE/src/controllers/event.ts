import { Request, Response } from "express";
import { Event } from "@interfaces/event";
import EventModel from "@models/event";
import HTTPCODE from "@root/magicnumber";

const get = async (req: Request, res: Response): Promise<Response<any>> => {
  const { issueid } = req.params;
  try {
    const result = await EventModel.select(Number(issueid));
    return res.json(result);
  } catch {
    return res.sendStatus(HTTPCODE.SERVER_ERR);
  }
};

const add = async (req: Request, res: Response): Promise<Response<any>> => {
  const event: Event = {
    id: null,
    issue_id: Number(req.params.issueid),
    user_id: req.body.user_id,
    log: req.body.log,
    created_at: new Date(),
  };
  const result = await EventModel.add(event);
  return res.sendStatus(result);
};

export default { get, add };
