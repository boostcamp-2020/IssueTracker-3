import { Request, Response } from "express";
import { Event } from "@interfaces/event";
import EventModel from "@models/event";

const get = async (req: Request, res: Response): Promise<Response<any>> => {
  const { issueid } = req.params;
  const result = await EventModel.select(Number(issueid));
  return res.json(result);
};

const add = async (req: Request, res: Response): Promise<Response<any>> => {
  const event: Event = {
    id: null,
    issue_id: Number(req.params.issueid),
    actor: req.body.actor,
    log: req.body.log,
    created_at: new Date(),
  };
  const result = await EventModel.add(event);
  return res.json(result);
};

export default { get, add };
