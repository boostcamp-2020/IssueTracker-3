/* eslint-disable camelcase */
export interface Event {
  id: number | null;
  issue_id: number;
  actor: string;
  log: string;
  created_at: Date;
}
