/* eslint-disable camelcase */
export interface Event {
  id: number | null;
  issue_id: number;
  user_id: number;
  log: string;
  created_at: Date;
}
