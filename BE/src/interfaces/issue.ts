/* eslint-disable camelcase */
export interface Issue {
  id: number;
  title: string;
  body: string;
  user_id: number;
  state: boolean;
  milestone_id: number;
  created_at: Date;
  closed_at: Date;
}
