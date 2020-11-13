/* eslint-disable camelcase */
export interface Issue {
  id: number | null;
  title: string;
  body: string;
  user_id: number;
  state: boolean;
  milestone_id: number | null;
  created_at: Date;
  closed_at: Date | null;
}
